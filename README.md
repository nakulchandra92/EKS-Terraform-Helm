
# EKS Tech Interview Solution

A production-ready Kubernetes application deployment on AWS EKS with automated scaling and CI/CD.

## Architecture

![Architecture Diagram](Architecture_Diagram.png)

## Features

- ✅ **EKS Cluster** deployed with Terraform
- ✅ **Auto-scaling** with HPA (2-10 pods) and Cluster Autoscaler (1-5 nodes)
- ✅ **Cost optimization** using spot instances (50-70% savings)
- ✅ **Health checks** with required endpoints
- ✅ **CI/CD** with GitHub Actions
- ✅ **Load balancing** with AWS ALB and Ingress

## Quick Start

### Prerequisites

```bash
# Install required tools
brew install docker kind kubectl helm terraform awscli
```

### Local Testing (Free)

```bash
# Test locally with Kind
chmod +x test-local.sh
./test-local.sh

# Test health endpoints
curl http://localhost:8080/      # Returns "OK"
curl http://localhost:8080/hello # Returns "world"
```

### AWS Deployment

```bash
# 1. Setup AWS credentials
aws configure

# 2. Create S3 bucket for Terraform state
aws s3 mb s3://your-terraform-state-bucket --region us-west-2

# 3. Update bucket name in terraform/main.tf
sed -i 's/eks-tech-interview-tfstate/your-bucket-name/g' terraform/main.tf

# 4. Deploy infrastructure
cd terraform/
terraform init
terraform apply

# 5. Configure kubectl
aws eks update-kubeconfig --region us-west-2 --name minimal-eks

# 6. Deploy application
cd ../helm/tech-interview/
helm upgrade --install tech-interview . --wait

# 7. Test endpoints
kubectl get ingress  # Get ALB URL
curl http://your-alb-url/
curl http://your-alb-url/hello
```

## GitHub Actions (Recommended)

1. **Add AWS credentials** to GitHub Secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

2. **Push to main branch**:
   ```bash
   git add .
   git commit -m "Deploy EKS solution"
   git push origin main
   ```

3. **Watch deployment** in GitHub Actions tab

## Project Structure

```
├── terraform/           # Infrastructure as Code
│   ├── main.tf         # EKS cluster configuration
│   └── variables.tf    # Configuration variables
├── helm/tech-interview/ # Kubernetes application
│   ├── values.yaml     # Application configuration
│   └── templates/      # K8s manifests
├── .github/workflows/  # CI/CD pipeline
└── test-local.sh      # Local testing script
```

## Health Checks

The application provides the required endpoints:

- `GET /` → Returns `"OK"` (Readiness probe)
- `GET /hello` → Returns `"world"` (Liveness probe)

## Auto-Scaling

- **Horizontal Pod Autoscaler**: Scales pods 2-10 based on CPU (70% threshold)
- **Cluster Autoscaler**: Scales nodes 1-5 based on pod demand
- **Spot Instances**: t3.medium spot instances for cost optimization

## Monitoring

- **Kubernetes Metrics**: Metrics Server provides CPU/memory data for auto-scaling
- **Health Checks**: Automated readiness and liveness probe monitoring
- **Basic AWS Metrics**: EKS automatically sends basic cluster metrics to CloudWatch

## Cleanup

```bash
# Delete local cluster
kind delete cluster --name tech-interview-test

# Delete AWS resources
cd terraform/
terraform destroy
```





