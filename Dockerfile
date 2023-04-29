# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt
RUN pip install requests
RUN apt-get update && apt-get install -y git
RUN pip install git+https://github.com/suno-ai/bark.git 
RUN pip uninstall -y torch torchvision torchaudio
RUN pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu118

# Expose port 80 for the API
EXPOSE 80

# Define environment variable
ENV NAME bark-api

# Run app.py when the container launches
CMD ["python", "app.py"]