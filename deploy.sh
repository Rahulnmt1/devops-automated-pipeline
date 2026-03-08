#!/bin/bash
set -e

echo "🚀 Starting End-to-End Deployment Pipeline..."

# Step 1: Provision Infrastructure
echo "📦 Provisioning AWS Infrastructure with Terraform..."
cd infrastructure
terraform init
terraform apply -auto-approve

# Extract the new Public IP
EC2_IP=$(terraform output -raw instance_public_ip)
echo "✅ Infrastructure Provisioned. EC2 Public IP: $EC2_IP"
cd ..

# Wait for SSH to become available
echo "⏳ Waiting for EC2 instance to initialize SSH..."
sleep 45

# Step 2: Configure and Deploy
echo "⚙️  Configuring Server and Deploying App with Ansible..."
# Disable host key checking strictly for automation purposes
export ANSIBLE_HOST_KEY_CHECKING=False

# Run Ansible, passing the dynamic IP directly as an inventory list (note the trailing comma)
ansible-playbook -i "$EC2_IP," -u ubuntu --private-key ./Nishant-ubuntu.pem configuration/deploy-app.yaml

echo "🎉 Deployment Complete! Access your application at: http://$EC2_IP"