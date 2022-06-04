from noisereduce.noisereducev1 import reduce_noise as nr
import librosa
import numpy as np
import scipy
import scipy.fftpack as fftpk
import utils
import torch

LABEL_MAP = {0: 'children', 1: 'dog', 2: 'gunshot', 3: 'siren', 4: 'red_alert'}

def final_decision(naive_class, smart_class):
    if naive_class == smart_class:
        return naive_class
    
    if naive_class in ["redAlert", "microwave"]:
        return naive_class

    return smart_class


class naiveClassifier:
    def __init__(self, sampling_rate):
        self.s_rate = sampling_rate 
    
    def classify(self, audio_wave):
        preprocessed_wave = self.preproccess(audio_wave)
        sound_type = self.classify_by_main_freq(preprocessed_wave)
        return sound_type

    def preproccess(self, audio_wave):
        
        audio_wave = audio_wave.astype(np.float)

        # Noise reduction
        noisy_part = audio_wave[0:25000]  
        reduced_noise = nr(audio_clip=audio_wave, noise_clip=noisy_part, verbose=False)
        
        #trimming silenced from the sides (librosa method that cuts silence from each side)
        trimmed, _ = librosa.effects.trim(reduced_noise, top_db=10, frame_length=512, hop_length=64)
        
        return trimmed
    

    def classify_by_main_freq(self, proccessed_wave):
        FFT = abs(scipy.fft.fft(proccessed_wave))
        freqs = fftpk.fftfreq(len(FFT), (1.0 / self.s_rate))
        maxfreq = freqs[range(len(FFT) // 2)][np.where(FFT[range(len(FFT) // 2)] == max(FFT[range(len(FFT) // 2)]))]
        
        #checking ranges for our sounds:
        #  2040 <  microwave < 2055
        #   <  microWave <
        #   <  gunshot <
        #   <  babycrying <
        #   <  doorbell <
        # unrecognizable < XX  && unrecognizable > XX
        
        if 2040 < maxfreq[0] < 2055:
            return 'microwave'
        else:
            return 'standard'


class smartClassifier:
    def __init__(self, model_path):
        self.label_map = LABEL_MAP
        self.feature_extractor, self.model = utils.load_wav2vec2_model(model_path)
        
    def classify(self, audio_wave):
        label = self.apply_model(audio_wave)
        return self.label_map[int(label)]
    
    def apply_model(self, audio_wave):
        input_values = self.feature_extractor(
            audio_wave, sampling_rate=self.feature_extractor.sampling_rate,
            max_length=16000, truncation=True, return_tensors='pt')['input_values']
        
        with torch.no_grad():
            raw_pred = self.model(input_values).logits
        
        return np.argmax(raw_pred, axis=1).item()

    
