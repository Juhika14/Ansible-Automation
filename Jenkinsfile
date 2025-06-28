pipeline {
  agent none

  stages {
    stage('Checkout Repo') {
      agent any
      steps {
        git branch: 'main',
            url: 'https://github.com/Juhika14/Ansible-Automation.git'
      }
    }

    stage('Run Playbook on Apache Agent') {
      agent { label 'Apache' }
      steps {
        dir('/home/ubuntu/jenkins/workspace/Test-PRT-Website') {
          sh 'ansible-playbook play.yaml'
        }
      }
    }

    stage('Run Playbook on Nginx Agent') {
      agent { label 'Nginx' }
      steps {
        dir('/home/ubuntu/jenkins/workspace/Test-PRT-Website') {
          sh 'ansible-playbook play.yaml'
        }
      }
    }
  }

  post {
    success { echo 'All playbooks completed succesfully!' }
    failure { echo 'Build failed—check log for errors.' }
  }
}


