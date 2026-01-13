# Flask DevSecOps Pipeline with Kubernetes

Proyek ini mendemonstrasikan implementasi alur kerja **DevSecOps** modern untuk aplikasi berbasis Python Flask. Sistem ini mengintegrasikan pemindaian keamanan otomatis tingkat lanjut, containerization, dan manajemen multi-environment menggunakan dual-platform CI/CD (GitLab & GitHub Actions).


## 🚀 Fitur Utama

- **SAST (Static Application Security Testing):**
  - **Bandit:** Pemindaian cepat untuk mendeteksi celah keamanan spesifik Python seperti *hardcoded passwords* atau *insecure imports*.
  - **SonarCloud:** Analisis mendalam untuk *Code Smells*, *Vulnerabilities*, dan *Bugs* dengan laporan komprehensif di dashboard cloud.
- **SCA & Container Security:** Menggunakan `Trivy` untuk memindai *base image* dan dependensi terhadap database CVE (Common Vulnerabilities and Exposures).
- **Automated Docker Workflow:** Build otomatis dengan tagging unik berbasis `Short SHA` untuk memastikan setiap deployment dapat dilacak dan di-*rollback*.
- **Multi-Environment Deployment:** Otomatisasi pembaruan manifest Kubernetes (Namespace & NodePort) untuk lingkungan **Staging** dan **Production**.

## 🏗️ Arsitektur Pipeline

Alur kerja keamanan dirancang untuk menggagalkan pipeline jika ditemukan risiko tinggi:

1. **Security Scan (SAST):** Menjalankan Bandit dan SonarCloud Scan secara paralel di tahap awal.
2. **Build:** Membangun Docker image dari Dockerfile.
3. **Security Check (Image Scan):** `Trivy` memindai image hasil build. Jika ditemukan celah dengan severity `HIGH` atau `CRITICAL`, pipeline akan berhenti otomatis.
4. **Push:** Mengirim image yang sudah tervalidasi ke Docker Hub.
5. **Deploy:** Injeksi konfigurasi environment ke manifest Kubernetes (Namespace & Port) menggunakan `sed`.



## 🛠️ Detail Environment

| Fitur | Staging Environment | Production Environment |
| :--- | :--- | :--- |
| **Branch** | `staging` | `main` |
| **Namespace K8s** | `staging` | `default` |
| **NodePort** | `30002` | `30001` |
| **SonarCloud Project** | `kikyputraa_devops-playground` | `kikyputraa_devops-playground` |

## ⚙️ Konfigurasi Secrets

Untuk menjalankan pipeline ini dengan sukses, pastikan variabel berikut telah diset pada **GitLab CI/CD Variables** atau **GitHub Actions Secrets**:

* `SONAR_TOKEN`: Token autentikasi dari SonarCloud.
* `SONAR_PROJECT_KEY`: Identitas unik proyek di SonarCloud.
* `SONAR_ORG_KEY`: Nama organisasi di SonarCloud.
* `DOCKER_USER`: Username Docker Hub.
* `DOCKER_PASSWORD`: Password atau Personal Access Token Docker Hub.

---