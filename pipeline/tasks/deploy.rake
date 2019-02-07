desc 'Deploy Grafana'
# rubocop:disable Metrics/BlockLength
task :deploy do
  puts 'deploy ecs cloudformation template'
  stack_name = 'GRAFANA-ECS'

  public_subnets = get_subnets('public')
  private_subnets = get_subnets('private')
  public_sg = @keystore.retrieve('PUBLIC_SECURITY_GROUP')
  private_sg = @keystore.retrieve('PRIVATE_SECURITY_GROUP')

  parameters = {
    'StackName' => stack_name,
    'VpcId' => @keystore.retrieve('VPC_ID'),
    'PrivateSubnetIds' => private_subnets,
    'PublicSubnetIds' => public_subnets,
    'AlbSecurityGroup' => public_sg,
    'EcsSecurityGroup' => private_sg,
    'DesiredCapacity' => '1',
    'MaxSize' => '1',
    'InstanceType' => 'm4.large',
    'ContainerName' => 'grafana',
    'CpuReservation' => '512',
    'MemoryReservation' => '1024',
    'KeyName' => @keystore.retrieve('SSH_KEYNAME'),
    'ImageName' => 'grafana/grafana',
    'Port' => @port,
    'SslCertArn' => @keystore.retrieve('SSL_CERT_ARN')
  }

  @cloudformation.deploy_stack(
    stack_name,
    parameters,
    'provisioning/ecs.yml'
  )
  puts 'done!'
end

def get_subnets(subnet_cluster)
  subnet_cluster.upcase!
  subnet1 = @keystore.retrieve("#{subnet_cluster}_SUBNET_1")
  subnet2 = @keystore.retrieve("#{subnet_cluster}_SUBNET_2")
  subnet3 = @keystore.retrieve("#{subnet_cluster}_SUBNET_3")
  [subnet1, subnet2, subnet3].join(',')
end
# rubocop:enable Metrics/BlockLength

desc 'Deploy RDS instance'
task :'deploy:rds' do
  puts 'deploy RDS cloudformation template'
  stack_name 'GRAFANA-RDS'

  parameters = {
    'StackName' => stack_name,
    'Vpc' => @keystore.retrieve('VPC_ID'),
    'DbSubnetGroupId' => @keystore.retrieve('PUBLIC_RDS_SUBNET_GROUP_ID'),
    'DbInstanceIdentifier' => 'GRAFANA-RDS',
    'DbSnapshotIdentifier' => 'GRAFANA-RDS',
    'DbUsername' => @keystore.retrieve('GRAFANA_RDS_USER'),
    'DbPassword' => @keystore.retrieve('GRAFANA_RDS_PASSWORD'),
    'DbInstanceClass' => 'db.t2.micro',
    'DbAllocatedStorage' => '20',
    'MultiAzEnabled' => 'false',
    'DbParameterGroup' => 'debezium-postgres96'
  }

  @cloudformation.deploy_stack(
    stack_name,
    parameters,
    'provisioning/rds.yml'
  )
end
