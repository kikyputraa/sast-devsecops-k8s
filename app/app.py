from flask import Flask

# Celah keamanan: Hardcoded Password & Bind to all interfaces
DEBUG_MODE = True
ADMIN_SECRET = "super_secret_password_123" # Ini akan memicu Bandit/Sonar

app = Flask(__name__)

@app.route("/")  # Pastikan menggunakan .route BUKAN .main
def hello():
    return "Hello, ini aplikasi Flask yang berjalan di Kubernetes!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)  # nosec