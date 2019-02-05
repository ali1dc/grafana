#!/usr/bin/env groovy
// @Library(pipeline-helpers)
// import pipeline.helpers.RVMHelper

repo_name = 'xd_grafana'

pipeline {
  agent any
  stages {

    stage('Commit') {
      steps {
        sh 'rm -rf ./*'

        checkout scm
        // rvm = new RVMHelper()
        // rvm.setup('2.5.3', repo_name)
        // sh 'source /usr/share/rvm/scripts/rvm'

        sh returnStdout: false, script: '''#!/bin/bash --login
          source /usr/share/rvm/scripts/rvm && \
            rvm use --install --create 2.5.3 && \
            export | egrep -i "(ruby|rvm)" > rvm.env
          rvm use default 2.5.3
          rvm alias create default ruby-2.5.3
          rvm list

          which bundle || gem install bundler
          bundle install
        '''
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
def rake(String task) {
  // sh "bundle exec rake $task"
  sh returnStdout: false, script: """#!/bin/bash --login
    set +x
    . rvm.env
    set -x
    bundle exec rake ${task}
  """
}
