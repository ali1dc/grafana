# rubocop:disable Metrics/BlockLength
desc 'Deploy Grafana Fargate'
task :'deploy:fargate' do
  puts 'deploy ecs cloudformation template'
  stack_name = 'XSP-GRAFANA-FARGATE'
  service_name = 'grafana'
  private_subnets = get_subnets('private')
  private_sg = @keystore.retrieve('PRIVATE_SECURITY_GROUP')
  target_group = \
    @cloudformation.stack_output('XSP-GRAFANA-ELB', 'TargetGroup')
  ecs_cluster = @keystore.retrieve('INTERNAL_ECS_CLUSTER')
  db_host = @cloudformation.stack_output('XSP-GRAFANA-RDS', 'DbHost')
  db_port = @cloudformation.stack_output('XSP-GRAFANA-RDS', 'DbPort')
  db_user = @keystore.retrieve('GRAFANA_RDS_USER')
  db_password = @keystore.retrieve('GRAFANA_RDS_PASSWORD')

  parameters = {
    'Cluster' => ecs_cluster,
    'ServiceName' => service_name,
    'VPC' => @keystore.retrieve('VPC_ID'),
    'PrivateSubnetIds' => private_subnets,
    'EcsSecurityGroup' => private_sg,
    'TargetGroup' => target_group,
    'Image' => 'grafana/grafana',
    'Port' => @port,
    'DbHost' => "#{db_host}:#{db_port}",
    'DbUser' => db_user,
    'DbPassword' => db_password
  }

  @cloudformation.deploy_stack(
    stack_name,
    parameters,
    'provisioning/fargate.yml',
    ['CAPABILITY_NAMED_IAM']
  )
  puts 'done!'
end
# rubocop:enable Metrics/BlockLength
