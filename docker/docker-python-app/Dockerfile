# Use a lightweight official Python runtime image
FROM python:3.14-slim

# Set the working directory inside the container
WORKDIR /app

# 1. Copy only the requirements file first to leverage Docker layer caching
COPY requirements.txt .

# 2. Install dependencies globally inside the container environment
RUN pip install --no-cache-dir -r requirements.txt

# 3. Copy the rest of your application code last
COPY . .

# Specify the default command to run when the container starts
CMD ["python", "app.py"]
