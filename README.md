# Flask DevSecOps Pipeline with Kubernetes

Proyek ini mendemonstrasikan implementasi alur kerja **DevSecOps** modern untuk aplikasi berbasis Python Flask. Sistem ini mengintegrasikan pemindaian keamanan otomatis, containerization, dan manajemen multi-environment (Staging & Production) menggunakan GitLab CI/CD dan Kubernetes.

## !Update
- (12/01) Migrating SonarQube to SonarCloud.
- (12/01) Adding Trivy Image Scan.

## 🚀 Fitur Utama

- **SAST (Static Application Security Testing):** Pemindaian kode otomatis menggunakan `Bandit` untuk mendeteksi celah keamanan sebelum proses build.
- **Automated Docker Workflow:** Build image otomatis dan push ke Docker Hub dengan tagging berbasis Git Commit SHA.
- **Multi-Environment Deployment:** Pemisahan lingkungan kerja antara **Staging** dan **Production** menggunakan Kubernetes Namespaces.
- **GitOps-Ready:** Perubahan manifest Kubernetes (image tag, namespace, dan port) diatur secara otomatis oleh pipeline berdasarkan branch.

## 🏗️ Arsitektur Pipeline

Pipeline GitLab CI/CD terdiri dari 4 tahap utama:

1.  **SAST:** Menjalankan security audit pada kode Python. Jika ditemukan celah (seperti *hardcoded bind*), pipeline akan berhenti.
2.  **Build:** Membangun Docker image dari Dockerfile.
3.  **Push:** Mengirim image ke Docker Hub.
4.  **Deploy:** Memperbarui manifest Kubernetes secara otomatis menggunakan `sed` untuk menyesuaikan target environment.



## 🛠️ Detail Environment

| Fitur | Staging Environment | Production Environment |
| :--- | :--- | :--- |
| **Branch** | `staging` | `main` |
| **Namespace K8s** | `staging` | `default` |
| **NodePort** | `30002` | `30001` |
| **Akses URL** | `http://minikube-ip:30002` | `http://minikube-ip:30001` |

## 📖 Panduan Penggunaan

### Prasyarat
- Minikube / Cluster Kubernetes terinstal.
- GitLab Runner terkonfigurasi.
- Docker Hub account.

### Menjalankan di Lokal (WSL)

1. **Clone Repositori:**
   ```bash
   git clone [https://gitlab.com/kikyputraa/sast-test.git](https://gitlab.com/kikyputraa/sast-test.git)
   cd sast-test
