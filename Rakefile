# frozen_string_literal: true

# $LOAD_PATH << './pipeline/lib'

require 'minimal_pipeline'
require './pipeline/tasks/shared/helper'
# require 'erb'

# Load any .rake files under the current directory
Dir.glob('pipeline/tasks/*.rake').each do |task_file|
  load task_file
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)
rescue LoadError
  print "Unable to load rubocop/rake_task, rubocop tests missing\n"
end
