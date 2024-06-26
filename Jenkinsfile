pipeline {
    environment {
        IMAGEN = "geobas/angular1"
        USUARIO = 'USER_DOCKERHUB4'
    }
    agent any
    stages {
        stage('Clone') {
            steps {
                git branch: "master", url: 'https://github.com/geobasti222/angular1.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    newApp = docker.build "$IMAGEN:$BUILD_NUMBER"
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker.image("$IMAGEN:$BUILD_NUMBER").inside('-u root') {
                           sh 'apache2ctl -v'
                        }
                    }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry( '', USUARIO ) {
                        newApp.push()
                    }
                }
            }
        }

    }
}
