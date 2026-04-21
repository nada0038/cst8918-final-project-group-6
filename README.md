# CST8918 Final Project

**Team 6 Members:**
- [Akash Nadackanal Vinod](https://github.com/YOUR_GITHUB_USERNAME)
- [Abijith Anil](https://github.com/YOUR_GITHUB_USERNAME)

**Professor:** Prof: Robert McKenney

## Overview

This is our final capstone project for CST8918. We're taking the Remix Weather App from our Week 3 Pulumi lab and deploying it using Terraform instead. The setup includes Azure Kubernetes Service (AKS) clusters and a managed Redis database for caching. We've also set up GitHub Actions to automate our Terraform runs and app deployments across test and prod environments.

## How to setup and run

1. **Bootstrap the Backend**:
    - Go to the `terraform/modules/backend` folder.
    - Run `terraform init` and `terraform apply`. This sets up the Azure blob storage required to store the main terraform state securely.
2. **GitHub Secrets**:
    - Make sure to configure OIDC federation as shown in our week 12 lab.
    - Add these secrets to the repository:
        - `AZURE_CLIENT_ID`
        - `AZURE_TENANT_ID`
        - `AZURE_SUBSCRIPTION_ID`
3. **Automated Workflows**:
    - Any push to a branch will trigger `tfsec` and tests.
    - Application code updates on a PR will build the Docker image and deploy to the test AKS cluster.
    - When the PR merges to main, it deploys the app to the production AKS cluster.
    - Infrastructure changes on PR trigger `terraform plan` and `tflint`.
    - Infrastructure changes merged to main trigger `terraform apply`.

## Code Structure

- Terraform code is split into modules (Network, AKS, Remix App logic, and Backend).
- We're using GitHub Actions for CI/CD across environments.
- Kubernetes deployment manifests for the app are in the `k8s/` folder.
