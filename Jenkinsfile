#!/usr/bin/env groovy
// @Library(pipeline-helpers)
// import pipeline.helpers.RVMHelper

repo_name = 'xd_grafana'

pipeline {
  agent any
  stages {
    stage('Commit') {

      properties([
        disableConcurrentBuilds(),
        pipelineTriggers([pollSCM('* * * * *')]),
      ])

      steps {
        sh 'rm -rf ./*'

        checkout scm
        // rvm = new RVMHelper()
        // rvm.setup('2.5.3', repo_name)

        rvm '2.5.3'
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

def rvm(String version) {
  sh returnStdout: false, script: """#!/bin/bash --login
    source /usr/share/rvm/scripts/rvm && \
      rvm use --install --create ${version} && \
      export | egrep -i "(ruby|rvm)" > rvm.env
    rvm use default ${version}
    rvm alias create default ruby-${version}

    which bundle || gem install bundler
    bundle install
  """
}

def rake(String task) {
  sh returnStdout: false, script: """#!/bin/bash --login
    set +x
    . rvm.env
    set -x
    bundle exec rake ${task}
  """
}
