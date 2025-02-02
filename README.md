# Odoo Deployment Automation on AWS

This repository automates the deployment of Odoo on AWS EC2 using Docker Compose, Terraform, and Ansible. The project is organized into the following folders:

## Folder Structure
```
├── ansible/
│   ├── playbook.yml
│   └── inventory.ini
├── docker-compose/
│   └── docker-compose.yml
└── terraform/
    └── main.tf
```



## Folders Overview

### `ansible/`

This folder contains Ansible playbooks to automate the deployment of Odoo on an AWS EC2 instance.

- **Inventory File**: The inventory file defines the connection details for your EC2 instance.
- **Playbook**: The playbook installs Docker, Docker Compose, copies the `docker-compose.yml` file to the EC2 instance, and starts the Odoo containers.

**Steps to use:**
1. Define your EC2 instance in the `inventory.ini` file.
2. Run the playbook to install Docker, deploy Docker Compose, and start Odoo.

### `docker-compose/`

This folder contains the `docker-compose.yml` file for containerizing Odoo and its PostgreSQL database.

- **docker-compose.yml**: Defines the Odoo and PostgreSQL services, including networking and volumes.

**Steps to use:**
1. Navigate to the `docker-compose/` folder.
2. Run `docker-compose up -d` to start the Odoo containers.

### `terraform/`

This folder contains Terraform configurations to provision the AWS infrastructure needed for Odoo deployment.

- **main.tf**: Defines the AWS provider, EC2 instance, and security group for Odoo.

**Steps to use:**
1. Run `terraform init` to initialize Terraform.
2. Run `terraform apply --auto-approve` to provision the AWS EC2 instance and security group.
3. Retrieve the public IP of the EC2 instance for accessing Odoo.

## How to Deploy

1. **Step 1: Provision Infrastructure with Terraform**
   - Navigate to the `terraform/` folder and run:
     ```bash
     terraform init
     terraform apply --auto-approve
     ```

2. **Step 2: Deploy Odoo with Ansible**
   - Navigate to the `ansible/` folder, configure the inventory file, and run:
     ```bash
     ansible-playbook -i inventory.ini deploy_odoo.yml
     ```

3. **Step 3: Access Odoo**
   - After the deployment completes, access Odoo in your browser via:
     ```
     http://<your-ec2-public-ip>:8069
     ```

## Conclusion

By using Docker, Terraform, and Ansible, this project ensures a consistent, repeatable, and scalable Odoo 