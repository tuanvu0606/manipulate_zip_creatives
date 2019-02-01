#!/usr/bin/env groovy

import java.util.Date
def now = new Date()
def formatted_now =  now.format("HH:mm.ddMMyy", TimeZone.getTimeZone('Asia/Bangkok')).toString()
def exported_pool = "https://s3-ap-southeast-1.amazonaws.com/tuan.vu.yoose"

// Wipe the workspace so we are building completely clean
//deleteDir()
//step([$class: 'WsCleanup'])


pipeline {
    agent any 
    parameters {
        choice(name: 'CAMPAIGN', choices: ['The_Coffee_House', 'Honda', 'Yamaha'], description: 'input campaign name')

        choice(name: 'WIDTH', choices: ['300', '320', '480', '728'], description: 'input campaign name')

        choice(name: 'HEIGHT', choices: ['50','90', '100','250','320','480'], description: 'input campaign name')
    }
    environment {
        PATH = "/usr/local/rvm/rubies/ruby-2.5.3/bin/:$PATH"
    }
    stages {        
        stage('Install all dependencies') { 
            steps {             
                //step([$class: 'WsCleanup'])         
                println formatted_now                          
                //sh "pip install awscli --upgrade --user"
                //sh "gem install google_places"
                //check ruby version

                //sh "gem install fileutils"
                //sh "gem install nokogiri"
                //sh "gem install open-uri"


                sh "which ruby"
                sh "which gem"
                sh "chmod +x -R ./html_parsing.rb"  
                sh "chmod +x -R ./css_utils_parsing.py"
                sh "chmod +x -R ./js_modify.py"                
            }
        }  
        stage ('get source file') {
            steps {
                sh "rm -rf ${workspace}/*.zip"
                sh "rm -rf ${workspace}/creative/*.*"
                sh "cp /home/jenkins/uploaded_creatives/* ${workspace}/creative/creative.zip"
                sh "chown -R jenkins ${workspace}/creative/creative.zip" 
                sh "cd ${workspace}/creative/"
                sh "pwd"
                sh "ls -la"
                sh "unzip -o ${workspace}/creative/creative.zip"
                sh "chown -R jenkins ${workspace}/*" 
                sh "rm -rf ${workspace}/creative/*.zip"
            }
        }

        stage ('manipulate HTML') {
            steps {
                sh """ruby ${workspace}/html_parsing.rb ${params.CAMPAIGN} ${params.WIDTH} ${params.HEIGHT}"""
            }
        }

        stage ('copy to creative folder, prepare to push') {
            steps {                
                sh "mv ${workspace}/function*.js ${workspace}/creative/"
                sh "mv ${workspace}/after*.css ${workspace}/creative/"
                sh "mv ${workspace}/after_processed.html ${workspace}/creative/index.html"
                sh "mv ${workspace}/*.png ${workspace}/creative/"                
            }
        }
        
    }
        post {
        always {
            archiveArtifacts artifacts: 'creative/*.html', onlyIfSuccessful: true
            archiveArtifacts artifacts: 'creative/*.css', onlyIfSuccessful: true
            archiveArtifacts artifacts: 'creative/*.js', onlyIfSuccessful: true
            archiveArtifacts artifacts: 'creative/*.png', onlyIfSuccessful: true            
        }
        success {            
            sh "echo /var/lib/jenkins/jobs/${JOB_NAME}/builds/${BUILD_NUMBER}/archive"
            step([$class: 'WsCleanup'])
            }       
        }            
    }
          


