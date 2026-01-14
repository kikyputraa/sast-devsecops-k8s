FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN pip install --no-cache-dir --upgrade pip setuptools \
    && pip install --no-cache-dir "jaraco.context>=6.1.0" \
    && find /usr/local/lib/python3.9/site-packages -name "jaraco.context-5.3.0.dist-info" -exec rm -rf {} +

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app/app.py"]