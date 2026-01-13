## 🆕 Update Terbaru
- (12/01) **Migrasi SonarCloud:** Integrasi pemindaian kualitas kode dan keamanan menggunakan SonarCloud dengan sistem *Secret Token*.
- (12/01) **Dual-CI/CD Workflow:** Mendukung GitHub Actions dan GitLab CI/CD secara bersamaan untuk fleksibilitas platform.
- (12/01) **Vulnerability Scanning:** Penambahan `Trivy` untuk memindai celah keamanan pada Docker Image sebelum di-push ke registry.
- (13/01) **CI/CD Automation:** Deployment otomatis dari GitHub ke mesin lokal melalui Runner Service.
- (13/01) **Infrastructure Resilience:** Membuktikan Self-Healing di Kubernetes Staging.
- (13/01) **Quality Gate Enforcement:** Berhasil mengintegrasikan standar Quality Gate SonarCloud ke dalam pipeline. Hal ini memastikan bahwa kode yang tidak memenuhi standar (seperti adanya Bugs, Vulnerabilities, atau Code Smells) akan otomatis menghentikan pipeline sebelum masuk ke tahap Build.
- (13/01) **Automated Code Coverage Reporting:** Mengonfigurasi pemindaian cakupan tes (Code Coverage) menggunakan pytest-cov. Hasil pengujian fungsional kini otomatis diekspor ke format coverage.xml dan dikirimkan ke SonarCloud untuk pemantauan kualitas jangka panjang.