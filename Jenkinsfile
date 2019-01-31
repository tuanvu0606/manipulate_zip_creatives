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
        string(name: 'HTML_BANNER_LINK', defaultValue: 'https://s3-ap-southeast-1.amazonaws.com/yoose-tmp/Banner_for_v4/TheCoffeeHouse_1/flashing_creatives_base.html')

        string(name: 'IMAGE_URL', defaultValue: 'https://s3-ap-southeast-1.amazonaws.com/yoose-tmp/Banner_for_v4/TheCoffeeHouse_1/BANNER-web-300x250.jpg')

        string(name: 'DISTANCE_FROM_TOP_TO_FLASHING_TEXT', defaultValue: '50px', description: 'distance of flashing text from top')

        string(name: 'WIDTH_OF_TEXT', defaultValue: '300px', description: 'width of flashing text')
        
        //text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')

        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')        

        choice(name: 'FROM_TO_COLOR', choices: ['red', 'white', 'brown'], description: 'Pick from to color')

        choice(name: 'STORE_COLOR', choices: ['white', 'red', 'blue'], description: 'Pick from to color')

        choice(name: 'CAMPAIGN', choices: ['The_Coffee_House', 'Honda', 'Yamaha'], description: 'Pick from to color')

        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')

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

