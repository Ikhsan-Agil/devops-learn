# Update your app.py script
cat << 'EOF' > app.py
import sys
import pandas as pd
from datetime import datetime

date = datetime.now()

df = pd.DataFrame({
    "Date": [date]
})

df.to_csv("date_creator.csv", index=False)

print("Hello from inside a custom Docker container!")
print(f"Python Version: {sys.version.split()[0]}")
print("Pandas successfully imported and CSV created internally!")
EOF

# Create the Dockerfile
cat << 'EOF' > Dockerfile
# Use a lightweight official Python runtime image
FROM python:3.11-slim

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
EOF

# Build Your Custom Image
docker build -t my-python-app:latest .

# Run Your Custom Container
docker run --rm my-python-app:latest
