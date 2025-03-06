# **Portfolio**

[![Contributors][contributors-shield]][contributors-url]  
[![Forks][forks-shield]][forks-url]  
[![Stargazers][stars-shield]][stars-url]  
[![Issues][issues-shield]][issues-url]  
[![MIT License][license-shield]][license-url]  

This repository contains the source code and deployment configuration for my portfolio website. The project is designed to demonstrate skills in Kubernetes, GitOps, and Continuous Deployment (CD) while providing a fully automated and reproducible deployment workflow.

The site is deployed using Kubernetes with GitOps principles, where changes pushed to this repository automatically trigger builds, image updates, and redeployment via ArgoCD. It is packaged as a Docker container and served with NGINX.

## **Features**

### **Cloud-Native Deployment**
- Runs in a Kubernetes cluster with namespace-based separation for staging and production.
- Uses ArgoCD to automate deployment synchronization.
- Traefik is used as an ingress controller to handle routing.

### **CI/CD Pipeline**
- GitHub Actions automates the build, test, and deployment processes.
- Docker images are built based on branch changes and pushed to GitHub Packages.
- A dedicated GitHub Actions runner is used for efficient builds.

### **Infrastructure as Code**
- Kubernetes manifests define all necessary components, including deployments, services, and ingress routes.
- Separate configurations for staging and production environments.

## **Technology Stack**
| Technology          | Purpose |
|---------------------|---------|
| **Kubernetes (k3s)** | Orchestrate and manage application deployment |
| **Docker**          | Containerize the frontend application |
| **NGINX**          | Serve static assets efficiently |
| **ArgoCD**         | Automate GitOps deployment and synchronization |
| **GitHub Actions**  | CI/CD pipeline to build and deploy images |
| **Traefik**        | Manage ingress routing and TLS termination |

## **File Structure**
```
Portfolio-main/
├── .github/workflows/           # CI/CD workflows
├── argo/                        # ArgoCD ApplicationSet for deployment
├── docker/                      # Docker & NGINX configuration
├── manifests/                   # Kubernetes YAML files for deployment
│   ├── prod/                    # Production environment
│   ├── stage/                   # Staging environment
├── scripts/                     # Deployment scripts
├── src/frontend/                 # Frontend source code
└── LICENSE                       # License information
```

## **Deployment Process**
### **1. Continuous Deployment**
- Changes to the `main` branch trigger the production deployment.
- Changes to the `stage` branch trigger the staging deployment.

### **2. GitHub Actions Workflow**
- Builds a Docker image from the source code.
- Pushes the image to GitHub Packages.
- Triggers an ArgoCD sync to update the Kubernetes cluster.

### **3. Kubernetes Deployment**
- `deployment.yaml` defines the container specification.
- `ingressroute.yaml` configures the Traefik ingress rules.
- `service.yaml` exposes the application within the cluster.

## **License**
This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.

## **Contact**
Website: [nordbye.it](https://nordbye.it)  
