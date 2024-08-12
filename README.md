# DevOps Project: Gaia Deployment and Infrastructure Management

This project demonstrates various DevOps practices including containerization, orchestration, observability, scripting, and infrastructure as code. It focuses on deploying and managing Cosmos Gaia v7.1.0 in a Kubernetes environment, along with additional infrastructure management tasks.

## Table of Contents

1. [Project Structure](#project-structure)
2. [Docker](#docker)
3. [Kubernetes](#kubernetes)
4. [Observability](#observability)
5. [Text Processing Scripts](#text-processing-scripts)
6. [Terraform IAM Module](#terraform-iam-module)

## Project Structure

```
project-root/
│
├── docker/
│   └── Dockerfile
│
├── kubernetes/
│   ├── gaia-statefulset.yaml
│   ├── gaia-service.yaml
│   └── gaia-servicemonitor.yaml
│
├── scripts/
│   ├── process_logs.sh
│   └── log_processor.py
│
├── terraform/
│   ├── main.tf
│   └── modules/
│       └── iam/
│           └── main.tf
│
└── sample.log
```

## Docker

The `docker/Dockerfile` contains instructions to build a Docker image for Cosmos Gaia v7.1.0. It uses a multi-stage build process to keep the final image size small and improve security.

To build the image:

```bash
cd docker
docker build -t somerepo/gaia:v7.1.0 .
```

To run the container:

```bash
docker run somerepo/gaia:v7.1.0
```

## Kubernetes

The `kubernetes/` directory contains YAML files for deploying Gaia in a Kubernetes cluster:

- `gaia-statefulset.yaml`: Defines a StatefulSet for running Gaia with persistent storage and resource limits.
- `gaia-service.yaml`: Creates a Service to expose Gaia pods.
- `gaia-servicemonitor.yaml`: Sets up a ServiceMonitor for Prometheus to scrape metrics from Gaia.

To apply these configurations:

```bash
kubectl apply -f kubernetes/
```

## Observability

Prometheus metrics are enabled for Gaia. The `gaia-servicemonitor.yaml` file sets up metric scraping. Ensure that Prometheus is configured in your cluster to use ServiceMonitor resources.

## Text Processing Scripts

Two scripts in the `scripts/` directory demonstrate text manipulation:

1. `process_logs.sh`: Uses `awk` and `sed` to process log files.
2. `log_processor.py`: A Python script that accomplishes the same task.

Both scripts extract ERROR level logs from `sample.log`, format the output, and sort by date.

To run the shell script:

```bash
./scripts/process_logs.sh
```

To run the Python script:

```bash
python scripts/log_processor.py
```

## Terraform IAM Module

The `terraform/` directory contains a module for creating AWS IAM resources:

- An IAM role that can be assumed by users in the same account
- An IAM policy allowing users to assume the role
- An IAM group with the policy attached
- An IAM user who is a member of the group

To use this module:

1. Navigate to the `terraform/` directory
2. Initialize Terraform: `terraform init`
3. Apply the configuration: `terraform apply`

The `main.tf` file demonstrates how to use this module.

## Note

This project is for demonstration purposes. Always thoroughly test configurations and scripts in a non-production environment before deploying to production. Ensure all security best practices are followed, especially for IAM configurations.