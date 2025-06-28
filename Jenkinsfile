pipeline {
    agent none

    stages {
        stage('Clone Repository') {
            agent any
            steps {
                git branch: 'main',
                    url: 'https://github.com/Juhika14/Ansible-Automation.git'
            }
        }

        stage('Run Ansible on Apache Agent') {
            agent { label 'Apache' }
            steps {
                sshagent(['ansible']) {
                    dir('/home/ubuntu/jenkins/workspace/Test-PRT-Website') {
                        sh 'ansible-playbook play.yaml'
                    }
                }
            }
        }

        stage('Run Ansible on Nginx Agent') {
            agent { label 'Nginx' }
            steps {
                sshagent(['ansible']) {
                    dir('/home/ubuntu/jenkins/workspace/Test-PRT-Website') {
                        sh 'ansible-playbook play.yaml'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Playbook completed successfully on both agents.'
        }
        failure {
            echo 'Build failed. Check logs for issues.'
        }
    }
}
