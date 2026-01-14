# Flask DevSecOps Pipeline with Kubernetes

This project demonstrates the implementation of a modern **DevSecOps** workflow for a Python Flask application. The system integrates advanced automated security scanning, containerization, and multi-environment management using a dual-platform CI/CD approach (GitLab & GitHub Actions).

---

### 🏗️ Build & Deployment
[![GitHub Pipeline](https://github.com/kikyputraa/devops-playground/actions/workflows/pipeline.yml/badge.svg?branch=staging)](https://github.com/kikyputraa/devops-playground/actions)
[![GitLab Pipeline](https://gitlab.com/kikyputraa/sast-test/badges/staging/pipeline.svg)](https://gitlab.com/kikyputraa/sast-test/-/commits/staging)
[![Docker Pulls](https://img.shields.io/docker/pulls/kikyputraa/devops-playground?style=flat&logo=docker&color=2496ed)](https://hub.docker.com/r/kikyputraa/devops-playground)
[![Last Commit](https://img.shields.io/github/last-commit/kikyputraa/devops-playground/staging?logo=git)](https://github.com/kikyputraa/devops-playground/commits/staging)

### 🛡️ Security & Quality Gate
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=kikyputraa_devops-playground&metric=alert_status)](https://sonarcloud.io/dashboard?id=kikyputraa_devops-playground)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=kikyputraa_devops-playground&metric=vulnerabilities)](https://sonarcloud.io/summary/new_code?id=kikyputraa_devops-playground)
![DevSecOps](https://img.shields.io/badge/DevSecOps-Automated-green?logo=shield)
![SAST](https://img.shields.io/badge/SAST-Bandit-blue)
![Container Scan](https://img.shields.io/badge/SCA-Trivy-blue)

### 🛠️ Infrastructure & Tech Stack
![Python](https://img.shields.io/badge/Python-3.9--slim-blue?logo=python)
![Docker](https://img.shields.io/badge/Docker-Containerized-blue?logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s/Minikube-blue?logo=kubernetes)
![Flask](https://img.shields.io/badge/Framework-Flask-lightgrey?logo=flask)

---

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

- **SAST (Static Application Security Testing):**
  - **Bandit:** Fast scanning to detect Python-specific security flaws like hardcoded passwords or insecure imports.
  - **SonarCloud:** Deep analysis for Code Smells, Vulnerabilities, and Bugs with comprehensive dashboard reports.
- **SCA & Container Security:** Utilizes `Trivy` to scan base images and dependencies against the CVE (Common Vulnerabilities and Exposures) database.
- **Automated Docker Workflow:** Automatic builds with unique tagging based on `Short SHA` to ensure every deployment is traceable and rollback-ready.
- **Multi-Environment Deployment:** Automated updates of Kubernetes manifests (Namespace & NodePort) for **Staging** and **Production** environments.

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