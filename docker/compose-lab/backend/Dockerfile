# --- Stage 1 : Build Dependencies ---
FROM python:3.14-slim AS builder

WORKDIR /app

# Install system build tools required for compiling C-extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Install dependencies into a user local directory for easy copying
RUN pip install --no-cache-dir --user -r requirements.txt


# --- Stage 2 : Production Runtime ---
FROM python:3.14-slim AS runner

WORKDIR /app

# Install only the minimal runtime libraries required (e.g., PostgreSQL client libs)
RUN apt-get update && apt-get install -y --no-install-recommends \
  libpq5 \
  && rm -rf /var/lib/apt/lists/*

# Copy installed python packages from the builder stage
COPY --from=builder /root/.local /root/.local
COPY app.py .
COPY test_app.py .

# Make sure local python binaries/scripts are accessible in PATH
ENV PATH=/root/.local/bin:$PATH

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "3", "app:app"]