# encoding: UTF-8

control 'eks-cis-5.5.1' do
  title 'draft'
  desc  "Amazon EKS uses IAM to provide authentication to your Kubernetes
cluster through the AWS IAM Authenticator for Kubernetes. You can configure the
stock kubectl client to work with Amazon EKS by installing the AWS IAM
Authenticator for Kubernetes and modifying your kubectl configuration file to
use it for authentication."
  desc  'rationale', "On- and off-boarding users is often difficult to automate
and prone to error. Using a single source of truth for user permissions reduces
the number of locations that an individual must be off-boarded from, and
prevents users gaining unique permissions sets that increase the cost of audit."
  desc  'check', "
    To Audit access to the namespace $NAMESPACE, assume the IAM role
yourIAMRoleName for a user that you created, and then run the following command:

    ```
    $ kubectl get role -n $NAMESPACE
    ```

    The response lists the RBAC role that has access to this Namespace.
  "
  desc  'fix', "Refer to the '[Managing users or IAM roles for your
cluster](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)'
in Amazon EKS documentation."
  impact 0.7
  tag severity: 'high'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['AC-2', 'Rev_4']
  tag cis_level: 2
  tag cis_controls: ['16.2', 'Rev_7']
  tag cis_rid: '5.5.1'
end
