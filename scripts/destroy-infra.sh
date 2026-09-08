#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Cloud-Native EKS Platform Infrastructure Teardown Script
# =============================================================================

ENV="${1:-dev}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TF_DIR="${DIR}/terraform/environments/${ENV}"

echo "============================================================"
echo " [WARNING] DESTROYING EKS PLATFORM INFRASTRUCTURE"
echo " Environment : ${ENV}"
echo " Directory   : ${TF_DIR}"
echo "============================================================"

read -p "Are you absolutely sure you want to destroy all resources? (Type 'yes' to proceed): " CONFIRM
if [ "${CONFIRM}" != "yes" ]; then
  echo "Destruction aborted."
  exit 0
fi

cd "${TF_DIR}"
terraform init
terraform destroy -auto-approve

echo "Infrastructure destroyed successfully."
