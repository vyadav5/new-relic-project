# DevOps Project: One-Click Automation for New Relic Infrastructure Agent

## Overview
This project provides a seamless and automated solution for deploying and managing the New Relic Infrastructure Agent on diverse environments using Terraform, Ansible, and Jenkins. The one-click automation streamlines the process of creating infrastructure, deploying the agent, and managing various versions on Ubuntu, Debian, and CentOS.

## Features
## 1) Infrastructure as Code (IaC): 
Utilizes Terraform to define and provision infrastructure on popular cloud platforms.

### 2) Configuration Management: 
Leverages Ansible to install and uninstall the New Relic Infrastructure Agent across multiple operating systems.

### 3) Jenkins Integration: 
Implements a Jenkins pipeline (Jenkinsfile) for one-click automation, allowing for easy, repeatable, and standardized deployments.

### 4) Version Flexibility: 
Supports the installation of different versions of the New Relic Infrastructure Agent, including older versions, providing flexibility for various use cases.

### 5) Cross-Platform Compatibility: 
Ensures compatibility across Ubuntu, Debian, and CentOS distributions.

## Prerequisites

Ensure you have the following prerequisites in place before using the DevOps project:

- **Jenkins:** Ensure Jenkins is installed and configured with appropriate permissions.
- **Terraform:** Install Terraform to manage infrastructure.
- **Ansible:** Install Ansible for configuration management.
- **New Relic Account:** Obtain necessary credentials like API key for New Relic.

### Dynamic Inventory Prerequisites

For dynamic inventory, additional prerequisites are required:

- **IAM Role:** Ensure the instance where you run dynamic inventory has an IAM role with the necessary permissions to access AWS resources.
- **boto3:** Install the `boto3` Python library, which is required for dynamic inventory scripts.

  ```bash
  pip install boto3
