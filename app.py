import requests
from bark import generate_audio, preload_models, SAMPLE_RATE
from fastapi import FastAPI

app = FastAPI()

# download and load all models
preload_models()

@app.post("/process")
def process(prompt: str):
    # generate audio from text
    audio_array = generate_audio(prompt)
    
    # convert audio to base64 for response
    audio_base64 = audio_array.tobytes().decode('latin1').encode('base64').decode('utf-8')
    
    return {"audio": audio_base64, "sample_rate": SAMPLE_RATE}
