# encoding: UTF-8

control 'eks-cis-5.3.1' do
  title 'Ensure Kubernetes Secrets are encrypted using Customer Master
  Keys (CMKs) managed in AWS KMS'
  desc  "Encrypt Kubernetes secrets, stored in etcd, using secrets encryption
feature during Amazon EKS cluster creation."
  desc  'rationale', "
    Kubernetes can store secrets that pods can access via a mounted volume.
Today, Kubernetes secrets are stored with Base64 encoding, but encrypting is
the recommended approach. Amazon EKS clusters version 1.13 and higher support
the capability of encrypting your Kubernetes secrets using AWS Key Management
Service (KMS) Customer Managed Keys (CMK). The only requirement is to enable
the encryption provider support during EKS cluster creation.

    Use AWS Key Management Service (KMS) keys to provide envelope encryption of
Kubernetes secrets stored in Amazon EKS. Implementing envelope encryption is
considered a security best practice for applications that store sensitive data
and is part of a defense in depth security strategy.

    Application-layer Secrets Encryption provides an additional layer of
security for sensitive data, such as user defined Secrets and Secrets required
for the operation of the cluster, such as service account keys, which are all
stored in etcd.

    Using this functionality, you can use a key, that you manage in AWS KMS, to
encrypt data at the application layer. This protects against attackers in the
event that they manage to gain access to etcd.
  "
  desc  'check', "
    For Amazon EKS clusters with Secrets Encryption enabled, look for
'encryptionConfig' configuration when you run:

    ```
    aws eks describe-cluster --name=\"<cluster-name>\"
    ```
  "
  desc  'fix', "Enable 'Secrets Encryption' during Amazon EKS cluster creation
as described in the links within the 'References' section."
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['SC-28', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['14.8', 'Rev_7']
  tag cis_rid: '5.3.1'

  region = input('cluster-region')
  name = input('cluster-name')

  encryption_enabled = command("aws eks describe-cluster --region #{region} --name #{name} --query cluster.encryptionConfig").stdout.strip

  describe "Encryption configuration" do
    subject { encryption_enabled }
    it { should_not eq "null" }
  end
end

