## 💡 What's Included (Core Features)

### ✅ **Scalability**
- **Horizontal Pod Autoscaler**: Scales 2-10 replicas based on CPU
- **Cluster Autoscaler**: Scales nodes 1-5 automatically  
- **Multi-AZ deployment**: High availability across 2 zones

### ✅ **Monitoring** 
- **CloudWatch**: Built-in AWS monitoring
- **Kubernetes metrics-server**: For HPA functionality
- **Health checks**: Readiness and liveness probes

### ✅ **Cost Optimization**
- **Spot instances**: 50% cost savings
- **Right-sized instances**: t3.medium for cost efficiency
- **Auto-scaling**: Only pay for what you use

### ✅ **Ease of Use**
- **Automated CI/CD**: GitHub Actions deploys on commit to main
- **Professional ingress**: AWS ALB with proper load balancing
- **Helm packaging**: Standardized deployment
- **Clear documentation**: Step-by-step GitHub Actions setup

### ✅ **Bonus Points Included:**
- **✅ Ingress configuration**: AWS Application Load Balancer with ALB Controller
- **✅ CI/CD pipeline**: Complete GitHub Actions workflow  
- **✅ Architecture design**: Multi-AZ, auto-scaling, spot instances






## 🚀 Quick Start with GitHub Actions (10 minutes)

### Prerequisites
```bash
# Only need AWS CLI and git
brew install awscli git

# Configure AWS
aws configure
```

### One-Time Setup
```bash
# 1. Create S3 bucket for Terraform state
aws s3 mb s3://eks-tech-interview-tfstate-$(date +%s) --region us-west-2

# 2. Clone and update bucket name
git clone <your-repo>
cd eks-tech-interview
sed -i 's/eks-tech-interview-tfstate/your-actual-bucket-name/g' terraform/main.tf

# 3. Add AWS credentials to GitHub Secrets:
# Go to GitHub repo → Settings → Secrets → Add:
# AWS_ACCESS_KEY_ID = your-key
# AWS_SECRET_ACCESS_KEY = your-secret
```

### Deploy Everything Automatically
```bash
# Just commit to main branch!
git add .
git commit -m "Deploy EKS tech interview solution"
git push origin main

# Watch deployment progress in GitHub Actions tab
# ✅ Infrastructure deploys automatically
# ✅ Application deploys automatically  
# ✅ Health checks run automatically
# ✅ Get load balancer URL in logs

# Test endpoints (from GitHub Actions output):
curl http://your-load-balancer/      # Returns "OK"  
curl http://your-load-balancer/hello # Returns "world"
```

## 📁 Project Structure (GitHub Actions)

```
├── README.md
├── .github/workflows/
│   └── deploy.yml           # Automated CI/CD pipeline
├── terraform/
│   ├── main.tf              # EKS infrastructure + S3 backend
│   ├── variables.tf         # Configuration
│   └── outputs.tf           # Important outputs
├── helm/
│   └── tech-interview/
│       ├── Chart.yaml       # Helm chart
│       ├── values.yaml      # Configuration
│       └── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           └── hpa.yaml
└── docs/
    └── setup-guide.md      # GitHub Actions setup
```

## 💡 What's Included (Core Features)

### ✅ **Scalability**
- **Horizontal Pod Autoscaler**: Scales 2-10 replicas based on CPU
- **Cluster Autoscaler**: Scales nodes 1-5 automatically  
- **Multi-AZ deployment**: High availability across 2 zones

### ✅ **Monitoring** 
- **CloudWatch**: Built-in AWS monitoring
- **Kubernetes metrics-server**: For HPA functionality
- **Health checks**: Readiness and liveness probes

### ✅ **Bonus Points Included:**
- **✅ Ingress configuration**: AWS Application Load Balancer with ALB Controller
- **✅ CI/CD pipeline**: Complete GitHub Actions workflow  
- **✅ Architecture design**: Multi-AZ, auto-scaling, spot instances
- **✅ Security considerations**: RBAC, security contexts, private subnets
- **✅ Cost optimization**: Spot instances, auto-scaling, efficient resources

### ✅ **Ease of Use**
- **Automated CI/CD**: GitHub Actions deploys on commit to main
- **No manual scripts**: Everything automated in the pipeline
- **Clear documentation**: Step-by-step GitHub Actions setup
- **Professional workflow**: PR validation → Main deployment

## 🔧 Core Configuration

### Terraform (Minimal)
- **EKS cluster**: Single node group with spot instances
- **VPC**: Simple public/private subnet design
- **Essential add-ons**: CoreDNS, kube-proxy, VPC CNI

### Helm Chart (Production-Ready)
- **Health probes**: Exactly as required
- **Auto-scaling**: HPA configuration  
- **Resource limits**: Proper resource management
- **Rolling updates**: Zero-downtime deployments

## 📊 Monitoring Dashboard

Access basic monitoring:
```bash
# View pod status
kubectl get pods

# Check HPA status  
kubectl get hpa

# View logs
kubectl logs -l app=tech-interview --tail=50

# Monitor resource usage
kubectl top pods
kubectl top nodes
```

## 🎯 Assessment Demo Script

```bash
# 1. Show infrastructure and ingress configuration
cat terraform/main.tf | grep -A 10 "aws_load_balancer_controller"
cat helm/tech-interview/templates/ingress.yaml

# 2. Show running resources
kubectl get all
kubectl get ingress

# 3. Test health endpoints via ALB
curl http://<alb-endpoint>/      # Returns "OK"
curl http://<alb-endpoint>/hello # Returns "world"

# 4. Demonstrate scaling
kubectl get hpa -w
# Generate load in another terminal to show scaling

# 5. Show cost optimization (spot instances)
kubectl get nodes -l karpenter.sh/capacity-type=spot

# 6. Show GitHub Actions pipeline
# Navigate to Actions tab - show automated deployment
```

## 🚀 Evolution Path to Full Solution

This minimal solution provides the foundation for the complete production system:

### Phase 1: Current (Assessment Ready)
- ✅ Core EKS cluster with Terraform
- ✅ Helm chart with health checks
- ✅ Basic auto-scaling
- ✅ Spot instances for cost savings

### Phase 2: Enhanced Monitoring
```bash
# Add Prometheus + Grafana
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install monitoring prometheus-community/kube-prometheus-stack
```

### Phase 3: Advanced Features
```bash
# Add ingress controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx

# Add cert-manager for SSL
helm repo add jetstack https://charts.jetstack.io
helm install cert-manager jetstack/cert-manager --set installCRDs=true
```

### Phase 4: Production Features
- Multi-tenancy with namespaces
- Advanced monitoring and alerting  
- CI/CD pipeline
- Security hardening

## 💰 Cost Estimate (Minimal)

| Component | Monthly Cost | Notes |
|-----------|-------------|--------|
| EKS Control Plane | $73 | Fixed cost |
| 2x t3.medium (spot) | ~$25 | 50-70% savings vs on-demand |
| Application Load Balancer | $18 | ALB for ingress |
| Data Transfer | $5-10 | Minimal for testing |
| **Total** | **~$121/month** | Very cost-effective |

*Note: ALB replaces classic LoadBalancer, providing better features at similar cost*

## 🔒 Security Basics

- **Private subnets** for worker nodes
- **Security groups** with minimal required access
- **Non-root containers** 
- **Resource limits** to prevent resource exhaustion

## ⚡ Quick Commands

```bash
# Get cluster info
kubectl cluster-info

# Check ingress status (ALB endpoint)
kubectl get ingress
kubectl describe ingress tech-interview

# Scale manually (test HPA)
kubectl scale deployment tech-interview --replicas=5

# View application logs
kubectl logs -f deployment/tech-interview

# Check resource usage
kubectl describe node

# Test endpoints via ALB
ENDPOINT=$(kubectl get ingress tech-interview -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
curl http://$ENDPOINT/           # Should return "OK"
curl http://$ENDPOINT/hello      # Should return "world"

# Monitor auto-scaling
kubectl get hpa -w
```

---

**Time Investment**: ~2-3 hours to deploy and understand  
**Assessment Ready**: All requirements met  
**Production Path**: Clear evolution to full-scale solution  

This minimal solution demonstrates all core concepts while being achievable in a single day, with a clear roadmap to the comprehensive production solution.