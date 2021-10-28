pipeline {
  agent any
  stages {
    stage('检出') {
      steps {
        checkout([
          $class: 'GitSCM', branches: [[name: env.GIT_BUILD_REF]],
          userRemoteConfigs: [[
            url: env.GIT_REPO_URL, 
            credentialsId: env.CREDENTIALS_ID
          ]]
        ])
      }
    }
    stage('构建') {
      steps {
        sh 'docker-compose build'
      }
    }
    stage('推送') {
      steps {
        script {
          // coding.net
          docker.withRegistry("https://${REG_HOST}/", CODING_ARTIFACTS_CREDENTIALS_ID) {
            sh 'docker-compose push'
          }
        }

      }
    }
  }
}