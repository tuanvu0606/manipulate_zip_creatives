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
        string(name: 'HTML_BANNER_LINK', defaultValue: 'nope')
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
        stage ('get source file') {
            steps {
                sh "rm -rf ${workspace}/*.zip"
                sh "cp /home/jenkins/uploaded_creatives/* ${workspace}/creative.zip"
                sh "chown -R jenkins ${workspace}/creative.zip" 
            }
        }
        
    }
          
}

