# Portfolio

## Overview
This repository contains the source code and deployment configurations for my personal portfolio website https://nordbye.it. It showcases my skills in DevOps, Kubernetes, Continuous Deployment, and Cloud Build Services. The site is deployed using GitHub Actions, ArgoCD, and Kubernetes.

## Repository Structure

```bash
.
├── argo/                # ArgoCD application manifests for prod and stage
├── docker/              # Docker-related files, including Nginx configuration
├── manifests/           # Kubernetes deployment and service manifests
├── scripts/             # Deployment scripts
├── src/                 # Frontend source code
│   ├── assets/          # CSS, images, and other static assets
│   ├── errors/          # Custom error pages
│   ├── forms/           # Backend PHP forms
│   ├── portfolio/       # Portfolio projects
│   ├── services/        # Descriptions of services I provide
│   ├── index.html       # Main website page
│   ├── robots.txt       # Search engine rules
│   ├── sitemap.xml      # Sitemap for SEO
│   └── starter-page.html # Template page
└── LICENSE              
```

## Deployment Workflow

### Continuous Deployment with GitHub Actions
This repository is configured with GitHub Actions to automate the build and deployment process:

1. **Build and Push Docker Image**: On changes to `main` or `stage`, a new image is built and pushed to GitHub Container Registry.
2. **ArgoCD Sync**: ArgoCD detects updates in the Kubernetes manifests and deploys the new version automatically.
3. **Kubernetes Deployment**: The portfolio is deployed as a containerized application within my k3s cluster.

## Technologies Used

- **Frontend**: HTML, CSS, JavaScript
- **Backend**: Nginx (serving static files)
- **Containerization**: Docker
- **Orchestration**: Kubernetes with k3s
- **Continuous Deployment**: GitHub Actions + ArgoCD
- **Cloud Build Services**: GitHub Container Registry (GHCR)