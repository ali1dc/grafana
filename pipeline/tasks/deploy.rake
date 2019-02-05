desc 'Deploy Grafana'
task :deploy do
  puts 'deploy ecs cloudformation template'
  stack_name = 'GRAFANA'

  subnet1 = @keystore.query?('PRIVATE_SUBNET_1')
  subnet2 = @keystore.query?('PRIVATE_SUBNET_2')
  subnet3 = @keystore.query?('PRIVATE_SUBNET_3')

  parameters = {
    'VpcId' => 'vpc-123456',
    'AsgSubnets' => %w[subnet1 subnet2 subnet3],
    'SubnetId' => '',
    'DesiredCapacity' => '1',
    'MaxSize' => '1',
    'InstanceType' => 'm4.large',
    'ContainerName' => 'grafana',
    'CpuReservation' => '512',
    'MemoryReservation' => '1024',
    'KeyName' => @keystore.query?('SSH_KEYNAME')
  }

  @cloudformation.deploy_stack('GRAFANA-ECS', parameters, 'provisioning/ecs.yaml')
  puts 'done!'
end
