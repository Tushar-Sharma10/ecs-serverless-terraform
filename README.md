# ECS Serverless Project Using Terraform

## Project Overview
This project demonstrates the deployment of a **serverless ECS Fargate service** on AWS using **Terraform**.  
It includes an **Application Load Balancer (ALB)**, **CloudWatch logging**, and **IAM roles** for secure and automated container execution.

The goal of this project is to showcase **Infrastructure as Code (IaC)** skills with Terraform and **AWS container orchestration** using ECS Fargate.

---

## Architecture Diagram
Internet
│
▼

Application Load Balancer (ALB) —> Target Group —> ECS Fargate Tasks
│
▼

Docker Container


---

## Project Components

1. **ECS Fargate**
   - Serverless container orchestration
   - Automatically manages container infrastructure
   - Tasks run in isolated VPC subnets

2. **Application Load Balancer (ALB)**
   - Listens on HTTP port 80
   - Routes traffic to ECS tasks
   - Health checks configured to ensure tasks are running

3. **IAM Roles**
   - **ecsTaskExecutionRole:** allows ECS to pull images and write logs to CloudWatch
   - **ecsTaskRole:** allows the container to access AWS resources if needed

4. **CloudWatch Logs**
   - Centralized logging for debugging and monitoring
   - Each container sends logs to `/ecs/terraform-infra` log group

5. **Terraform**
   - Infrastructure as Code to automate deployment
   - Manages ALB, Target Groups, ECS Cluster, Tasks, Security Groups, IAM Roles, and CloudWatch Logs

---

## Prerequisites

- **AWS Account** with required permissions (ECS, ALB, IAM, VPC, CloudWatch)
- **Terraform v1.5+**
- **Docker image** for your app (already pushed to ECR or Docker Hub)
- **AWS CLI** configured with access keys

---

### Deployment Steps

1. Clone the repository:
   git clone
   https://github.com/Tushar-Sharma10/ecs-serverless-terraform.git
   
   cd ecs-serverless-terraform


2. Initialize Terraform: terraform init
   

3. Review Terraform Plan: terraform plan
   

4. Apply Terraform Configuration: terraform apply -auto-approve
   

---

### Verification

ECS Tasks Running: RUNNING in ECS Console

Target Group Health: 2/2 healthy

CloudWatch Logs: `/ecs/terraform-infra contains container logs

App Accessible: via ALB DNS URL in browser

---

### Outcome

By completing this project, I demonstrated:

1. Terraform proficiency for AWS infrastructure

2. ECS Fargate deployment and serverless container management

3. ALB & Target Group setup for high availability

4. CloudWatch logging for monitoring and debugging

5. IAM role creation and security best practices

---

 ###  LinkedIn: www.linkedin.com/in/tusharsharma-tech
