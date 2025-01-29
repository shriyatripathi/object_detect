FROM python:3.8-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file into the container
COPY requirements.txt .

# Install system dependencies and Jupyter
RUN apt-get update && apt-get install -y \
    libsm6 libxext6 libxrender-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && pip install jupyter

# Copy the rest of your code into the container
COPY . .

# Expose the port for Jupyter Notebook
EXPOSE 8888

# Run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip", "0.0.0.0", "--port", "8888", "--allow-root"]

