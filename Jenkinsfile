#!/usr/bin/env groovy
@Library(pipeline-gelpers)
import pipeline.helpers.RVMHelper

repo_name = xd_grafana

pipeline {
  agent any
  stages {

    stage('Commit') {
      steps {
        sh 'sudo rm -rf ./*'
        checkout scm
        rvm = new RVMHelper()
        rvm.setup('2.5.3', repo_name)
      }
    }

    stage('Code Analysis') {
      steps {
        rake 'rubocop'
      }
    }

    stage('Deployment') {
      steps {
        rake 'deploy'
      }
    }
  }
}

// Helper function for rake
def rake(String command) {
  sh "bundle exec rake $command"
}
