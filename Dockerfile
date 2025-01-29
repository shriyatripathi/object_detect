# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies (OpenCV dependencies, etc.)
RUN apt-get update && apt-get install -y \
    libsm6 libxext6 libxrender-dev \
    && pip install opencv-python-headless \
    && pip install tensorflow \
    && pip install jupyter 

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8888 for Jupyter
EXPOSE 8888

# Command to run Jupyter Notebook when the container starts
CMD ["jupyter", "notebook", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root"]
