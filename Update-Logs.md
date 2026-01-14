## 🆕 Latest Updates

- (12/01) **SonarCloud Migration:** Integrated code quality and security scanning using SonarCloud with a Secret Token system.
- (12/01) **Dual-CI/CD Workflow:** Support for both GitHub Actions and GitLab CI/CD simultaneously for platform flexibility.
- (12/01) **Vulnerability Scanning:** Added `Trivy` to scan Docker images for security vulnerabilities before pushing to the registry.
- (13/01) **CI/CD Automation:** Automated deployment from GitHub to local machines via Runner Service.
- (13/01) **Infrastructure Resilience:** Demonstrated Self-Healing capabilities within the Kubernetes Staging environment.
- (13/01) **Quality Gate Enforcement:** Successfully integrated SonarCloud Quality Gate standards into the pipeline. This ensures that code not meeting standards (e.g., Bugs, Vulnerabilities, or Code Smells) automatically halts the pipeline before the Build stage.
- (13/01) **Automated Code Coverage Reporting:** Configured test coverage scanning using `pytest-cov`. Functional test results are now automatically exported to `coverage.xml` and sent to SonarCloud for long-term quality monitoring.
- (14/01) **Elastic Infrastructure with HPA:** Implemented *Horizontal Pod Autoscaler* (HPA) for automated workload management. Scalability was validated through load testing, successfully triggering automatic pod scaling (Min: 2, Max: 5) when CPU load exceeded the 50% threshold.
- (14/01) **Zero Downtime Strategy:** Applied a *Rolling Update* strategy to the Deployment configuration. This guarantees 100% service availability (zero downtime) during application updates by ensuring new pods are ready before old ones are terminated.
- (14/01) **Enhanced Health Monitoring (Self-Healing):** Integrated *Liveness* and *Readiness Probes*. The system is now capable of detecting unhealthy pods and performing automatic restarts, while ensuring traffic is only routed to containers ready to serve requests.
- (14/01) **Resource Quota & Optimization:** Established *CPU/Memory Requests* and *Limits* at the container level. This is crucial to prevent resource exhaustion and ensure long-term cluster stability.