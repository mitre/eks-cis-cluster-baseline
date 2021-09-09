# encoding: UTF-8

control 'eks-cis-5.1.3' do
  title 'draft'
  desc  "Configure the Cluster Service Account with Storage Object Viewer Role
to only allow read-only access to Amazon ECR."
  desc  'rationale', "The Cluster Service Account does not require
administrative access to Amazon ECR, only requiring pull access to containers
to deploy onto Amazon EKS. Restricting permissions follows the principles of
least privilege and prevents credentials from being abused beyond the required
role."
  desc  'check', "
    Review AWS ECS worker node IAM role (NodeInstanceRole) IAM Policy
Permissions to verify that they are set and the minimum required level.

    If utilizing a 3rd party tool to scan images utilize the minimum required
permission level required to interact with the cluster - generally this should
be read-only.
  "
  desc  'fix', "
    You can use your Amazon ECR images with Amazon EKS, but you need to satisfy
the following prerequisites.

    The Amazon EKS worker node IAM role (NodeInstanceRole) that you use with
your worker nodes must possess the following IAM policy permissions for Amazon
ECR.

    ```
    {
     \"Version\": \"2012-10-17\",
     \"Statement\": [
     {
     \"Effect\": \"Allow\",
     \"Action\": [
     \"ecr:BatchCheckLayerAvailability\",
     \"ecr:BatchGetImage\",
     \"ecr:GetDownloadUrlForLayer\",
     \"ecr:GetAuthorizationToken\"
     ],
     \"Resource\": \"*\"
     }
     ]
    }
    ```
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['RA-5 (5)', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['3.2', 'Rev_7']
  tag cis_rid: '5.1.3'
end

