control 'eks-cis-5.4.2' do
  title 'Ensure clusters are created with Private Endpoint Enabled and
  Public Access Disabled'
  desc  "Disable access to the Kubernetes API from outside the node network if
it is not required."
  desc  'rationale', "
    In a private cluster, the master node has two endpoints, a private and
public endpoint. The private endpoint is the internal IP address of the master,
behind an internal load balancer in the master's VPC network. Nodes communicate
with the master using the private endpoint. The public endpoint enables the
Kubernetes API to be accessed from outside the master's VPC network.

    Although Kubernetes API requires an authorized token to perform sensitive
actions, a vulnerability could potentially expose the Kubernetes publically
with unrestricted access. Additionally, an attacker may be able to identify the
current cluster and Kubernetes API version and determine whether it is
vulnerable to an attack. Unless required, disabling public endpoint will help
prevent such threats, and require the attacker to be on the master's VPC
network to perform any attack on the Kubernetes API.
  "
  desc  'check', ''
  desc  'fix', ''
  impact 0.7
  tag severity: 'high'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['SC-7 (8)', 'Rev_4']
  tag cis_level: 2
  tag cis_controls: ['12', 'Rev_7']
  tag cis_rid: '5.4.2'

  region = input('cluster-region')
  name = input('cluster-name')

  expected_allowlist = input('allowlist_cidr_blocks')

  access_restrictions = json({ command: "aws eks describe-cluster --region #{region} --name #{name} --query cluster.resourcesVpcConfig" })
  actual_allowlist = access_restrictions['publicAccessCidrs']

  describe 'Private access should be enabled' do
    subject { access_restrictions }
    its('endpointPrivateAccess') { should be true }
  end

  describe.one do
    describe 'Public access should be disabled' do
      subject { access_restrictions }
      its('endpointPublicAccess') { should be false }
    end
    describe 'Public access should be restricted to an allowlist of CIDR blocks' do
      subject { actual_allowlist }
      it { should_not eq nil }
    end
  end
  if actual_allowlist
    actual_allowlist.each do |cidr|
      describe 'Cluster allowlist should match expected allowlist' do
        subject { cidr }
        it { should be_in expected_allowlist }
      end
    end
  end
end
