pipeline {
    agent any
    environment {
        TERRAFORM_WORKSPACE = "/var/lib/jenkins/workspace/NewRelic/terraform/"
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
    }
}
