def getEnvPort(BRANCH_NAME) {
  if (BRANCH_NAME == 'develop') {
    return 6200
  } else {
    return 6000
  }
}

pipeline {
  environment {
    BRANCH_NAME = "${buildEnv}"
    PORT = getEnvPort(BRANCH_NAME)
    gitRepo = "https://github.com/Mehtavarun/DevopsAssignmentNagp.git"
    username = "varunmehta02"
  }

  agent any

  tools {
    maven "Maven3"
  }

  options {
    timeout(time: 1, unit: "HOURS")

    skipDefaultCheckout()
  }

  stages {
    stage('checkout') {
      
      checkout([$class: 'GitSCM', branches: [['*/develop', '*/feature']], url: gitRepo])
      
    }
    stage('build') {

      bat "mvn install"

    }
    stage('test') {

      bat "mvn test"

    }
    stage('sonar analysis') {

      bat "mvn sonar:sonar -Dtest.sonar.exclusions=**/*test.*"

    }
    stage('push to artifactory') {

      rtMavenDeployer(
        id: 'deployer',
        snapshotRepo: 'NAGPRepo',
        releaseRepo: 'NAGPRepo',
        serverId: '123456789@artifactory'
      )
      rtMavenRun(
        pom: 'pom.xml',
        goals: 'install',
        deployerId: 'deployer'
      )
      rtPublishBuildInfo (
        serverId: '123456789@artifactory'
      )

    }
    stage('docker build image') {
  
      bat "docker build -t varun/JavaCode_${BRANCH_NAME.toLowerCase()}:${BUILD_Number}  Dockerfile ."

    }
    stage('docker stop and remove container') {

      bat "docker ps -aq --filter \"name=varun_JavaCode_${BRANCH_NAME.toLowerCase()}\" | findstr . && docker stop varun_JavaCode_${BRANCH_NAME.toLowerCase()} && docker rm varun_JavaCode_${BRANCH_NAME.toLowerCase()} | echo \"no container found to stop\""

    }
    stage('docker start new container') {

      bat "docker run -d --name varun_JavaCode_${BRANCH_NAME.toLowerCase()}"

    }
  }
}