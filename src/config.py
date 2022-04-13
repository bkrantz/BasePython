import os
from src.app import app
from dotenv import load_dotenv

load_dotenv()

#app.config['SAMPLE_ENV_VARIABLE'] = os.getenv('SAMPLE_ENV_VARIABLE')