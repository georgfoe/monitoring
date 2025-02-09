pipeline {
    agent any

    environment {
        IMAGE_NAME = "ghcr.io/${GITHUB_REPOSITORY}/r-script:latest"
        CONTAINER_NAME = "monitoring"
    }

    stages {
        stage('Pull Latest Image') {
            steps {
                script {
                    sh "docker login ghcr.io -u $GITHUB_ACTOR -p ${GITHUB_PAT}"
                    sh "docker pull ${IMAGE_NAME}"
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh "docker run --rm --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    sh "docker image prune -f"
                }
            }
        }
    }

    triggers {
        cron('H/5 * * * *') // Alle 5 Minuten
    }
}
