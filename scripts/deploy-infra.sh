#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Cloud-Native EKS Platform Infrastructure Deployment Script
# =============================================================================

ENV="${1:-dev}"
REGION="${2:-us-east-1}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TF_DIR="${DIR}/terraform/environments/${ENV}"

echo "============================================================"
echo " Deploying EKS Platform Infrastructure"
echo " Environment : ${ENV}"
echo " Region      : ${REGION}"
echo " Directory   : ${TF_DIR}"
echo "============================================================"

if [ ! -d "${TF_DIR}" ]; then
  echo "Error: Environment directory ${TF_DIR} not found!"
  exit 1
fi

cd "${TF_DIR}"

echo "[Step 1/4] Checking prerequisites..."
command -v terraform >/dev/null 2>&1 || { echo "Terraform is required but not installed."; exit 1; }
command -v aws >/dev/null 2>&1 || { echo "AWS CLI is required but not installed."; exit 1; }

echo "[Step 2/4] Initializing Terraform..."
terraform init -upgrade

echo "[Step 3/4] Creating execution plan..."
terraform plan -out=tfplan.binary

echo "[Step 4/4] Applying execution plan..."
terraform apply -auto-approve tfplan.binary

echo "============================================================"
echo " Infrastructure provisioned successfully!"
echo " Cluster Name: $(terraform output -raw cluster_name)"
echo " API Endpoint: $(terraform output -raw cluster_endpoint)"
echo "============================================================"
