#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Terraform Formatting and Syntax Validation Script
# =============================================================================

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Checking Terraform formatting across repo..."
terraform fmt -check -recursive "${DIR}/terraform"
echo "Terraform formatting check PASSED."

echo "Validating root Terraform modules..."
cd "${DIR}/terraform"
terraform init -backend=false
terraform validate
echo "Root module validation PASSED."

echo "Validating dev environment..."
cd "${DIR}/terraform/environments/dev"
terraform init -backend=false
terraform validate
echo "Dev environment validation PASSED."

echo "All Terraform validations completed successfully!"
