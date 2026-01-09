FROM python:3.9-slim
WORKDIR /app

# Ambil requirements dari dalam folder app
COPY app/requirements.txt .
RUN pip install -r requirements.txt

# Salin semua file
COPY . .

# Jalankan aplikasi (pastikan path benar)
CMD ["python", "app/app.py"]