from flask import Flask, render_template, send_from_directory
import os

app = Flask(__name__)

# Route untuk file statis seperti CSS/Gambar
@app.route('/static/<path:filename>')
def serve_static(filename):
    root_dir = os.path.dirname(os.getcwd())
    return send_from_directory(os.path.join(root_dir, 'app', 'static'), filename)

@app.route('/')
def hello_world():
    message = "Selamat datang di K8s Explorer Anda!"
    subtitle = "Aplikasi ini berjalan di Kubernetes!"
    return render_template('index.html', message=message, subtitle=subtitle)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)