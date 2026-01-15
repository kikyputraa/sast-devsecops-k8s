# DevSecOps Project

This project demonstrates the implementation of a modern **DevSecOps** workflow for a Python Flask application. The system integrates advanced automated security scanning, containerization, and multi-environment management using a dual-platform CI/CD approach (GitLab & GitHub Actions).

---

### 🏗️ CI/CD & Registry Dashboard
| Platform | Status Badge | Context / Branch |
| :--- | :--- | :--- |
| **GitLab CI/CD** | [![GitLab Pipeline](https://img.shields.io/gitlab/pipeline-status/kikyputraa/sast-test?branch=staging&label=GitLab%20Pipeline&logo=gitlab&color=orange)](https://gitlab.com/kikyputraa/sast-test/-/pipelines) | `Primary Pipeline (Staging)` |
| **GitHub Actions** | [![GitHub Pipeline](https://img.shields.io/github/actions/workflow/status/kikyputraa/devops-playground/pipeline.yml?branch=staging&label=GitHub%20Actions%20Pipeline&logo=github)](https://github.com/kikyputraa/devops-playground/actions) | `Secondary Pipeline (Sync)` |
| **Docker Hub** | [![Docker Pulls](https://img.shields.io/docker/pulls/kikyputraa/devops-playground?style=flat&logo=docker&color=2496ed)](https://hub.docker.com/r/kikyputraa/devops-playground) | `Container Registry` |
| **Git Activity** | [![Last Commit](https://img.shields.io/github/last-commit/kikyputraa/devops-playground/staging?style=flat&logo=git&logoColor=white)](https://github.com/kikyputraa/devops-playground/commits/staging) | `Latest Updates` |

### 🛡️ Security & Code Quality Gate
| Audit Type | Metric / Status | Methodology |
| :--- | :--- | :--- |
| **Quality Gate** | [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=kikyputraa_devops-playground&metric=alert_status)](https://sonarcloud.io/dashboard?id=kikyputraa_devops-playground) | `SonarCloud Analysis` |
| **Security Scan** | [![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=kikyputraa_devops-playground&metric=vulnerabilities)](https://sonarcloud.io/summary/new_code?id=kikyputraa_devops-playground) | `Trivy & Bandit` |
| **Code Security** | ![Bandit](https://img.shields.io/badge/SAST-Bandit-00599c?style=flat&logo=python) | `SAST` | Static analysis for Python security vulnerabilities. |
| **Image Security** | ![Trivy](https://img.shields.io/badge/SCA-Trivy-red?style=flat&logo=trivy) | `SCA` | Container vulnerability & misconfiguration scanning. |
| **Strategy** | ![DevSecOps](https://img.shields.io/badge/DevSecOps-Automated-44cc11?style=flat&logo=shield) | `Shift-Left Security` |

### 🛠️ Infrastructure & Tech Stack
| Component | Technology | Specification |
| :--- | :--- | :--- |
| **Language** | ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | `Version 3.11-slim` |
| **Framework** | ![Flask](https://img.shields.io/badge/Flask-000000?style=flat&logo=flask&logoColor=white) | `Lightweight Microservices` |
| **Container** | ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white) | `Multi-stage Builds` |
| **Orchestrator** | ![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat&logo=kubernetes&logoColor=white) | `K3s / Minikube Cluster` |

### ⚙️ Kubernetes Resilience & Observability
| Feature | Efficiency Status | Purpose |
| :--- | :--- | :--- |
| **Autoscaling** | ![HPA](https://img.shields.io/badge/HPA-Enabled-orange?style=flat&logo=kubernetes) | `CPU-based Auto Scaling` |
| **Self-Healing** | ![Self-Healing](https://img.shields.io/badge/Infrastructure-Self--Healing-blueviolet?style=flat&logo=kubernetes) | `Liveness & Readiness Probes` |
| **Availability** | ![Zero-Downtime](https://img.shields.io/badge/Deployment-Zero--Downtime-brightgreen?style=flat&logo=target) | `Rolling Update Strategy` |
| **Traffic Management** | ![Ingress](https://img.shields.io/badge/Ingress-Nginx-informational?style=flat&logo=nginx) | `Host-based Routing` |


## 📋 Prerequisites

To run this project from development to automated deployment, you will need the following components:

### 1. Accounts & Cloud SaaS Access
* **GitHub & GitLab:** Repositories for source code management and CI/CD engine execution.
* **SonarCloud:** Account connected to the repository for Static Application Security Testing (SAST).
* **Docker Hub:** Registry for storing and distributing built Docker images.

### 2. Infrastructure & Runners
* **Docker Engine:**
  - Primary runtime for building application images.
  - Driver for running Kubernetes clusters (Minikube/Kind).
  - Must be installed on the machine running the CI/CD Runners.
* **Kubernetes Cluster (Minikube/K3s):** Must run on the Docker driver for environment simulation.
* **Kubectl:** CLI tool to manage deployments after the Docker image is successfully built.
* **CI/CD Runners:**
  - **GitHub Self-hosted Runner** or **GitLab Runner** installed on a machine with access to the Kubernetes cluster.
  - Runners must have permissions to execute `docker` commands (access to `docker.sock`) and `kubectl`.

### 3. Local Machine Software (Optional for Testing)
For local testing before pushing to the repository:
* **Python 3.9+** & **Pip** (to run Flask & Pytest).
* **Docker Engine** (for local image builds).
* **Kubectl CLI** (for cluster management).
* **Trivy CLI** & **Bandit** (for local security scanning).

### 4. Essential Configuration Files
Ensure the following files are in the project root directory:
* `sonar-project.properties`: SonarCloud project identification.
* `Dockerfile`: Application container configuration.
* `k8s/`: Folder containing `deployment.yaml` and `service.yml` manifests.
* `requirements.txt`: List of Python dependencies (Flask, Pytest-cov, etc.).

## 🚀 Key Features
- **Elasticity & Auto-scaling:** Dynamic pod scaling based on real-time resource utilization (CPU Metrics).
- **Self-Healing Infrastructure:** Automated detection and recovery of unhealthy pods via Liveness and Readiness probes.
- **Zero Downtime Deployment:** Seamless application updates using the `RollingUpdate` strategy to eliminate service interruption.
- **SAST (Static Application Security Testing):** Deep analysis for Code Smells, Vulnerabilities, and Bugs via Bandit and SonarCloud.
- **SCA & Container Security:** Utilizes `Trivy` to scan base images and dependencies against the CVE database.



## 🏗️ Pipeline Architecture

The security workflow is designed to fail the pipeline if high-risk issues are detected:

1. **Security Scan (SAST):** Runs Bandit and SonarCloud Scan in parallel at the initial stage.
2. **Build:** Builds the Docker image from the Dockerfile.
3. **Security Check (Image Scan):** `Trivy` scans the built image. If `HIGH` or `CRITICAL` severity vulnerabilities are found, the pipeline stops automatically.
4. **Push:** Sends validated images to Docker Hub.
5. **Deploy:** Injects environment configurations into Kubernetes manifests (Namespace & Port) using `sed`.

## 🛠️ Environment Details

| Feature | Staging Environment | Production Environment |
| :--- | :--- | :--- |
| **Branch** | `staging` | `main` |
| **K8s Namespace** | `staging` | `default` |
| **NodePort** | `30002` | `30001` |
| **SonarCloud Project** | `kikyputraa_devops-playground` | `kikyputraa_devops-playground` |

## ⚙️ Secrets Configuration

To run this pipeline successfully, ensure the following variables are set in **GitLab CI/CD Variables** or **GitHub Actions Secrets**:

* `SONAR_TOKEN`: Authentication token from SonarCloud.
* `SONAR_PROJECT_KEY`: Unique project identifier in SonarCloud.
* `SONAR_ORG_KEY`: Organization name in SonarCloud.
* `DOCKER_USER`: Docker Hub username.
* `DOCKER_PASSWORD`: Docker Hub password or Personal Access Token.


---
**Maintained by [kikyputraa](https://github.com/kikyputraa)**