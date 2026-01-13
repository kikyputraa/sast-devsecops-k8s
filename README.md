# Flask DevSecOps Pipeline with Kubernetes

![CI](https://github.com/kikyputraa/devops-playground/actions/workflows/pipeline.yml/badge.svg)
[![pipeline status](https://gitlab.com/kikyputraa/sast-test/badges/staging/pipeline.svg)](https://gitlab.com/kikyputraa/sast-test/-/commits/staging)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=kikyputraa_devops-playground&metric=alert_status)](https://sonarcloud.io/dashboard?id=kikyputraa_devops-playground)
![Last Commit](https://img.shields.io/github/last-commit/kikyputraa/devops-playground)

![Python](https://img.shields.io/badge/python-3.9-slim)
![Docker](https://img.shields.io/badge/docker-enabled-blue)
![Kubernetes](https://img.shields.io/badge/kubernetes-ready-blue)

![DevSecOps](https://img.shields.io/badge/DevSecOps-enabled-green)
![SAST](https://img.shields.io/badge/SAST-Bandit-blue)
![Container%20Scan](https://img.shields.io/badge/Trivy-container--scan-blue)


Proyek ini mendemonstrasikan implementasi alur kerja **DevSecOps** modern untuk aplikasi berbasis Python Flask. Sistem ini mengintegrasikan pemindaian keamanan otomatis tingkat lanjut, containerization, dan manajemen multi-environment menggunakan dual-platform CI/CD (GitLab & GitHub Actions).

## 🛠️ Prasyarat (Requirements)

Untuk menjalankan proyek ini dari tahap pengembangan hingga deployment otomatis, Anda memerlukan beberapa komponen berikut:

### 1. Akun & Akses Layanan (Cloud SaaS)
* **GitHub & GitLab:** Repositori untuk menyimpan kode dan menjalankan engine CI/CD.
* **SonarCloud:** Akun yang terhubung ke repositori untuk analisis keamanan kode (SAST).
* **Docker Hub:** Registry untuk menyimpan dan mendistribusikan Docker Image hasil build.

### 2. Infrastruktur & Runner
* **Docker Engine:**
  - Sebagai runtime utama untuk membangun (build) image aplikasi.
  - Sebagai driver untuk menjalankan cluster Kubernetes (Minikube/Kind).
  - Wajib terinstal di mesin yang menjalankan Runner (GitHub/GitLab).
* **Kubernetes Cluster (Minikube/K3s):** - Harus berjalan di atas Docker driver untuk simulasi environment.
* **Kubectl:** - CLI untuk mengelola deployment setelah Docker image berhasil dibuat.
* **CI/CD Runner:**
  - **GitHub Self-hosted Runner** atau **GitLab Runner** terinstal pada mesin yang memiliki akses ke cluster Kubernetes.
  - Runner harus memiliki izin untuk mengeksekusi perintah `docker` (akses ke `docker.sock`) dan `kubectl`.

### 3. Software di Mesin Lokal (Opsional untuk Testing)
Jika ingin melakukan pengujian sebelum melakukan push ke repositori:
* **Python 3.9+** & **Pip** (untuk menjalankan Flask & Pytest).
* **Docker Engine** (untuk build image lokal).
* **Kubectl CLI** (untuk manajemen cluster).
* **Trivy CLI** & **Bandit** (untuk pemindaian keamanan lokal).

### 4. Konfigurasi File Esensial
Pastikan file-file berikut berada di root direktori proyek:
* `sonar-project.properties`: Berisi identitas proyek SonarCloud.
* `Dockerfile`: Konfigurasi container aplikasi.
* `k8s/`: Folder berisi manifest `deployment.yaml` dan `service.yml`.
* `requirements.txt`: Daftar dependensi Python (Flask, Pytest-cov, dll).


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

## Output Pipeline dan Quality Check
- **GitHub Actions Pipeline :**
![alt text](<WhatsApp Image 2026-01-13 at 16.25.03.jpeg>)
- **GitLab Pipeline :**
![alt text](<WhatsApp Image 2026-01-13 at 16.25.54.jpeg>)
- **SonarCloud Quality Analysis :**
![alt text](<WhatsApp Image 2026-01-13 at 16.26.35.jpeg>)

---