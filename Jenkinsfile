pipeline {
    agent any

        stages {
            stage('Preparacion') {
                steps {
                    git branch: 'main', url: 'https://github.com/Mesias-Caleb/shop2.git'
                    echo 'Obtenido de Github con éxito'
                }
           }
        
        stage('Verifica version php'){
            steps {
                sh 'php --version'
            }
        }

        stage('Pruebas unitarias php'){
            steps {
                //sh 'chmod 0775 vendor/bin/phpunit'
                sh 'chmod +x ./vendor/bin/phpunit'
                sh './vendor/bin/phpunit'
            }
        }
         //Revisa la calidad de código con SonarQube
        //stage ('Sonarqube') {
        //    steps {
        //        script {
        //            def scannerHome = tool name: 'sonarscanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation';
        //            echo "scannerHome = $scannerHome ...."
        //            withSonarQubeEnv() {
        //                sh "$scannerHome/bin/sonar-scanner"
        //            }
        //        }
        //    }
        //}

        stage('Compilación de Docker') {
            steps {
                sh 'docker build -t appmarket .'
            }
        }

         stage('Implementar php') {
            steps {
                sh 'docker compose up -d'
            }
        }      
    }
}
