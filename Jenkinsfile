pipeline {
    agent any
    environment {
        TERRAFORM_WORKSPACE = "/home/ubuntu/new-relic-terra/"
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', credentialsId: 'newrelic-jenkins', url: 'https://github.com/vyadav5/new-relic-project.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform init"
            }
        }
    }
}
