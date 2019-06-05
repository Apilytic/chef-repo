#
# Cookbook Name:: gsa
# Recipe:: eip
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

aws_user, aws_password = decrypt_passwords_data_bag_item(node['gsa']['secret_path'].to_s, 'gsa_codedeploy_password')

bash 'attach eip' do
  environment ({AWS_ACCESS_KEY_ID: aws_user, AWS_SECRET_ACCESS_KEY: aws_password, AWS_DEFAULT_REGION: "eu-west-1"})
  code <<-EOH
INSTANCE_ID=`aws autoscaling describe-auto-scaling-instances \
  --output text --query "AutoScalingInstances[?AutoScalingGroupName=='prod'].InstanceId"`

aws ec2 associate-address --instance-id $INSTANCE_ID --allocation-id eipalloc-0efee59f6261069a1
  EOH
end
