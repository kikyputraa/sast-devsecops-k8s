FROM python:3.9-slim
WORKDIR /app
COPY app/requirements.txt .
RUN pip install -r requirements.txt
COPY app/ . 
# Perintah di atas otomatis cuma copy app.py dan requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]