desc 'Deploy Grafana ELB'
task :'deploy:elb' do
  puts 'deploy elb cloudformation template'
  stack_name = 'XSP-GRAFANA-ELB'

  public_subnets = get_subnets('public')
  public_sg = @keystore.retrieve('PUBLIC_SECURITY_GROUP')

  parameters = {
    'VpcId' => @keystore.retrieve('VPC_ID'),
    'SubnetIds' => public_subnets,
    'SecurityGroupId' => public_sg,
    'Port' => @port
    # todo: add cert later
    # 'SslCertArn' => @keystore.retrieve('SSL_CERT_ARN')
  }

  @cloudformation.deploy_stack(
    stack_name,
    parameters,
    'provisioning/elb.yml'
  )
  puts 'done!'
end
