import librosa
from transformers import AutoFeatureExtractor, AutoModelForAudioClassification



def load_audio_file(audio_file):
    wave , _ = librosa.load(audio_file, sr=16000) # move sr to config file
    return wave

def load_wav2vec2_model(path):
    feature_extractor = AutoFeatureExtractor.from_pretrained(path)
    model = AutoModelForAudioClassification.from_pretrained(path)
    return feature_extractor, model