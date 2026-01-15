FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 1. Upgrade pip ke versi terbaru
RUN pip install --no-cache-dir --upgrade pip

# 2. Hapus setuptools bawaan yang bermasalah dan install versi yang bersih
# Kita pakai versi 70.0.0+ yang biasanya sudah nge-patch vendorized libs
RUN pip uninstall -y setuptools jaraco.context && \
    pip install --no-cache-dir "setuptools>=70.0.0" "jaraco.context>=6.1.0"

# 3. Hapus folder vendor jaraco secara paksa jika masih nyangkut di dalam setuptools
RUN find /usr/local/lib/python3.9/site-packages/setuptools/_vendor -name "jaraco*" -exec rm -rf {} + || true

COPY app/requirements.txt .
# Install requirements tanpa menyentuh setuptools lagi
RUN pip install --no-cache-dir --no-deps -r requirements.txt && \
    pip install --no-cache-dir Flask==2.3.3 pytest==7.4.2 pytest-cov==4.1.0 bandit==1.7.5

COPY app/ .

EXPOSE 5000
CMD ["python", "app.py"]