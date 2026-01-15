FROM python:3.11-slim

WORKDIR /app

# Upgrade pip dan install jaraco.context versi terbaru untuk fix Trivy HIGH
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir "jaraco.context>=6.1.0"

# Install dependencies aplikasi
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy aplikasi
COPY app/ .

EXPOSE 5000

CMD ["python", "app.py"]