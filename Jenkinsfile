pipeline {
    agent any
    environment {
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
                    sudo cp ${env.TERRAFORM_WORKSPACE}/newrelic.pem ${env.ANSIBLE_WORKSPACE}/playbook/newrelic.pem
                    sudo chown jenkins:jenkins ${env.ANSIBLE_WORKSPACE}/pgsql.pem
                    sudo chmod 400 ${env.ANSIBLE_WORKSPACE}/newrelic.pem
                """       
            }
        }
    }
}
