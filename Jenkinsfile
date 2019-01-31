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
        file(name: "creative.zip", description: "Choose a file to upload")
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
                sh "which ruby"
                sh "which gem"
                sh "chmod +x -R ./html_parsing.rb"  
                sh "chmod +x -R ./css_utils_parsing.py"
                sh "chmod +x -R ./js_modify.py"                
            }
        }  
        stage("upload") {
            steps {
                sh "ls -a"
            }
        
        }      
        stage('Parsing HTML') { 
            steps {                
                println exported_pool

                //parse html, change HTML and image source files url                
                sh """ruby ${workspace}/html_parsing.rb ${params.HTML_BANNER_LINK} ${params.IMAGE_URL} ${exported_pool}/${params.CAMPAIGN}/${BUILD_NUMBER}/newprefs.js ${exported_pool}/${params.CAMPAIGN}/${BUILD_NUMBER}/style_new.css ${formatted_now}"""

                //sh "echo $JOB_NAME"
                //sh "echo $BUILD_TAG"
                //sh "echo ${workspace}"
            }
        }
        stage('Parsing CSS') { 
            steps {                
                //parse css by css utils
                sh "python ${workspace}/css_utils_parsing.py ${params.STORE_COLOR} ${params.DISTANCE_FROM_TOP_TO_FLASHING_TEXT} ${params.WIDTH_OF_TEXT}"                
            }
        }
        stage('Parsing Java Scripts') { 
            steps {
                //parse javascript, change color from from_to characters.
                sh "python ${workspace}/js_modify.py ${params.FROM_TO_COLOR}"                
            }
        }
        stage('Compress HTML') { 
            steps {
                echo 'test'
            }
        }        
    }
    post {
        always {
            archiveArtifacts artifacts: '*.html', onlyIfSuccessful: true
            archiveArtifacts artifacts: '*.css', onlyIfSuccessful: true
            archiveArtifacts artifacts: '*.js', onlyIfSuccessful: true
        }
        success {            
            sh "echo /var/lib/jenkins/jobs/AWS_flashing_creatives_pipeline/builds/${BUILD_NUMBER}/archive"
            sh """~/.local/bin/aws s3 cp /var/lib/jenkins/jobs/AWS_flashing_creatives_pipeline/builds/${BUILD_NUMBER}/archive s3://tuan.vu.yoose/${params.CAMPAIGN}/${BUILD_NUMBER} --recursive --exclude "*" --include "*.html" --include "*.js" --include "*.css" --acl public-read"""
            step([$class: 'WsCleanup'])
            }       
        }            
    }

