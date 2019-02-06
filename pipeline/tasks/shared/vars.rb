@cloudformation = MinimalPipeline::Cloudformation.new
@docker = MinimalPipeline::Docker.new
@keystore = MinimalPipeline::Keystore.new

ENV['AWS_REGION'] = 'us-east-1'
@port = 3000
