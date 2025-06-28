pipeline {
  agent none

  stages {
    stage('Checkout Repo') {
      agent any
      steps {
        git branch: 'main', url: 'https://github.com/Juhika14/Ansible-Automation.git'
      }
    }

    stage('Run Playbook on Apache Agent') {
      agent { label 'Apache' }
      steps {
        dir('/home/ubuntu/jenkins/workspace/Test-PRT-Website') {
          sh '''
            # Add Apache host to known_hosts to avoid verification failures
            ssh-keyscan -H 10.0.1.200 >> ~/.ssh/known_hosts || true
            ansible-playbook -i inventory.ini play.yaml
          '''
        }
      }
    }

    stage('Run Playbook on Nginx Agent') {
      agent { label 'Nginx' }
      steps {
        dir('/home/ubuntu/jenkins/workspace/Test-PRT-Website') {
          sh '''
            # Add Nginx host to known_hosts
            ssh-keyscan -H 10.0.1.38 >> ~/.ssh/known_hosts || true
            ansible-playbook -i inventory.ini play.yaml
          '''
        }
      }
    }
  }

  post {
    success { echo 'Playbooks executed!' }
    failure { echo 'Build failed—check console logs.' }
  }
}




