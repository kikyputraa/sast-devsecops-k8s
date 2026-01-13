## 🆕 Update Terbaru
- **Migrasi SonarCloud:** Integrasi pemindaian kualitas kode dan keamanan menggunakan SonarCloud dengan sistem *Secret Token*.
- **Dual-CI/CD Workflow:** Mendukung GitHub Actions dan GitLab CI/CD secara bersamaan untuk fleksibilitas platform.
- **Vulnerability Scanning:** Penambahan `Trivy` untuk memindai celah keamanan pada Docker Image sebelum di-push ke registry.
- **CI/CD Automation:** Deployment otomatis dari GitHub ke mesin lokal melalui Runner Service.
- **Infrastructure Resilience:** Membuktikan Self-Healing di Kubernetes Staging.