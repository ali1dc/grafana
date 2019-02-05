#!/usr/bin/env groovy
@Library(pipeline-helpers)
import pipeline.helpers.RVMHelper

repo_name = 'xd_grafana'

pipeline {
  agent any
  stages {

    stage('Commit') {
      steps {
        sh 'rm -rf ./*'
        checkout scm
        rvm = new RVMHelper()
        rvm.setup('2.5.3', repo_name)
        sh 'ruby --version'
        sh 'rvm list'
        sh 'whoami'
        // sh 'rvm use ruby-2.5.3'

        sh 'bundle install'
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
