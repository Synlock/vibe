import utils
from logic import naiveClassifier, smartClassifier, final_decision
import sys
import json


config = json.load(open('config.json'))

naive_classifier = naiveClassifier(config['naive_sampling_rate'])
smart_classifier = smartClassifier(config['smart_model_path'])

def classify(audio_file):
    
    #  load and pre-processing 
    audio_wave = utils.load_audio_file(audio_file) 
    
    # apply naive logic
    naive_classification = naive_classifier.classify(audio_wave)
    
    # apply smart logic
    smart_classification = smart_classifier.classify(audio_wave)

    # return the final decision
    return final_decision(naive_classification, smart_classification)


if __name__ == '__main__':
    prediction = classify(sys.argv[1])
    print(prediction)
