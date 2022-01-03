control 'eks-cis-2.1.1' do
  title 'Enable audit logs'
  desc  "The audit logs are part of the EKS managed Kubernetes control plane
logs that are managed by Amazon EKS. Amazon EKS is integrated with AWS
CloudTrail, a service that provides a record of actions taken by a user, role,
or an AWS service in Amazon EKS. CloudTrail captures all API calls for Amazon
EKS as events. The calls captured include calls from the Amazon EKS console and
code calls to the Amazon EKS API operations."
  desc  'rationale', "Exporting logs and metrics to a dedicated, persistent
datastore such as CloudTrail ensures availability of audit data following a
cluster security event, and provides a central location for analysis of log and
metric data collated from multiple sources."
  desc  'check', "
    Perform the following to determine if CloudTrail is enabled for all regions:

    **Via the Management Console**

    1. Sign in to the AWS Management Console and open the EKS console at
https://console.aws.amazon.com/eks
    1. Click on Cluster Name of the cluster you are auditing
    1. Click Logging
     You will see Control Plane Logging info

     ```
     API Server Audit Authenticator
     Enabled/Disabled Enabled/Disabled Enabled/Disabled

     Controller Manager Scheduler
     Enabled/Disabled Enabled/Disabled
    ```
    4. Ensure all 5 choices are set to Enabled
  "
  desc 'fix', "
    Perform the following to determine if CloudTrail is enabled for all regions:

    **Via The Management Console**

    1. Sign in to the AWS Management Console and open the EKS console at
https://console.aws.amazon.com/eks
    1. Click on Cluster Name of the cluster you are auditing
    1. Click Logging
    1. Select Manage Logging from the button on the right hand side
    1. Toggle each selection to the Enabled position.
    1. Click Save Changes

    **Via CLI**

    `aws --region \"${REGION_CODE}\" eks describe-cluster --name
\"${CLUSTER_NAME}\" --query
'cluster.logging.clusterLogging[?enabled==true].types`
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['AU-6']
  tag cis_level: 1
  tag cis_controls: ['6', 'Rev_7']
  tag cis_rid: '2.1.1'

  region = input('cluster-region')
  name = input('cluster-name')

  log_types_enabled = json({ command: "aws eks describe-cluster --region #{region} --name #{name} --query cluster.logging.clusterLogging[?enabled].types" }).flatten

  describe 'All five logging types should be enabled' do
    subject { log_types_enabled }
    it { should include 'api' }
    it { should include 'audit' }
    it { should include 'authentication' }
    it { should include 'controllerManager' }
    it { should include 'scheduler' }
  end
end
