pipeline {
  agent none

  stages {
    stage('Clone Repository') {
      agent any
      steps {
        git branch: 'main', url: 'https://github.com/Juhika14/Ansible-Automation.git'
      }
    }

    stage('Run Ansible on Apache Agent') {
      agent { label 'Apache' }
      steps {
        withCredentials([sshUserPrivateKey(credentialsId: 'ansible', keyFileVariable: 'KEYFILE')]) {
          dir('/home/ubuntu/jenkins/workspace/Test-PRT-Website') {
            sh '''
              eval "$(ssh-agent -s)"
              ssh-add "$KEYFILE"
              ansible-playbook play.yaml -i inventory.ini
            '''
          }
        }
      }
    }

    stage('Run Ansible on Nginx Agent') {
      agent { label 'Nginx' }
      steps {
        withCredentials([sshUserPrivateKey(credentialsId: 'ansible', keyFileVariable: 'KEYFILE')]) {
          dir('/home/ubuntu/jenkins/workspace/Test-PRT-Website') {
            sh '''
              eval "$(ssh-agent -s)"
              ssh-add "$KEYFILE"
              ansible-playbook play.yaml -i inventory.ini
            '''
          }
        }
      }
    }
  }

  post {
    success { echo '✅ Playbooks completed successfully.' }
    failure { echo '❌ Build failed—check console output.' }
  }
}

