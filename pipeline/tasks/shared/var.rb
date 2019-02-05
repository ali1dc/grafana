@cloudformation = MinimalPipeline::Cloudformation.new
@docker = MinimalPipeline::Docker.new
@keystore = MinimalPipeline::Keystore.new

# ENV['AWS_REGION'] = ENV['REGION']
@port = 80
