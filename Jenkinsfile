pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action: apply or destroy')
        choice(name: 'UNINSTALL', choices: ['yes', 'no'], description: 'Select: yes or no')
    }
    environment {
        // LICENSE_KEY = null
        TERRAFORM_WORKSPACE = "/var/lib/jenkins/workspace/NewRelic/terraform/"
        ANSIBLE_WORKSPACE = "/var/lib/jenkins/workspace/NewRelic/ansible/"
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', credentialsId: 'newrelic-jenkins', url: 'https://github.com/vyadav5/new-relic-project.git'
            }
        }
        stage('Terraform Init') {
            steps {
                // Initialize Terraform
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform init"
            }
        }
        stage('Terraform Plan') {
            steps {
                // Run Terraform plan
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform plan"
            }
        }
        stage('Approval For Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                // Prompt for approval before applying changes
                input "Do you want to apply Terraform changes?"
            }
        }
        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                // Run Terraform apply
                sh """
                    cd ${env.TERRAFORM_WORKSPACE}
                    terraform apply -auto-approve
                    sudo cp ${env.TERRAFORM_WORKSPACE}newrelic.pem ${env.ANSIBLE_WORKSPACE}newrelic.pem
                    sudo chown jenkins:jenkins ${env.ANSIBLE_WORKSPACE}newrelic.pem
                    sudo chmod 400 ${env.ANSIBLE_WORKSPACE}newrelic.pem
                """       
            }
        }
        stage('Approval for Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                // Prompt for approval before destroying resources
                input "Do you want to Terraform Destroy?"
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                // Destroy Infra
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform destroy -auto-approve"
            }
        }
        stage('Prompt for License Key') {
            steps {
                script {
                    // Use input to prompt the user for the license key and mask it
                    env.LICENSE_KEY = input(
                        id: 'LicenseInput',
                        message: 'Please enter your license key:',
                        parameters: [password(name: 'LICENSE_KEY', description: 'License Key')]
                    )

                    // Print a masked message indicating that the license key has been received
                    echo "Received license key (masked): ********"
                }
            }
        }
        stage('Install NewRelic') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sh "cd ${env.ANSIBLE_WORKSPACE} && ansible-playbook my_playbook.yml --tags=version_specific -e \"license=${env.LICENSE_KEY}\""
            }
        }
        stage('Uninstall NewRelic') {
            when {
                expression { params.UNINSTALL == 'yes' }
            }
            steps {
                input "Do you want to uninstall NewRelic?"
                script {
                    
                    echo "Uninstalling NewRelic..."
                    sh "cd ${env.ANSIBLE_WORKSPACE} && ansible-playbook my_playbook.yml --tags=uninstall"
                }
            }
        }
    }
}
