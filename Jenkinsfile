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
        stage('Copy Terraform Files') {
            steps {
                script {
                    sh "mkdir -p ${TERRAFORM_WORKSPACE}"

                    // copy file
                    sh "cp -R /home/ubuntu/new-relic-terra/* ${TERRAFORM_WORKSPACE}/"
                }
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    // Run terraform init in the Jenkins workspace
                    dir(TERRAFORM_WORKSPACE) {
                        sh 'terraform init'
                    }
                }
            }
        }
    }
}
