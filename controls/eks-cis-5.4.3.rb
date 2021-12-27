control 'eks-cis-5.4.3' do
  title 'Ensure clusters are created with Private Nodes'
  desc  "Disable public IP addresses for cluster nodes, so that they only have
private IP addresses. Private Nodes are nodes with no public IP addresses."
  desc  'rationale', "Disabling public IP addresses on cluster nodes restricts
access to only internal networks, forcing attackers to obtain local network
access before attempting to compromise the underlying Kubernetes hosts."
  desc  'check', ''
  desc  'fix', ''
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['SC-7 (8)', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: %w(12 Rev_7)
  tag cis_rid: '5.4.3'

  address_key = os.windows? ? '\"ExternalIP\"' : 'ExternalIP'

  node_external_addresses = command("kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type==#{address_key})].address}'").stdout.strip

  describe 'The list of externally accessible IP addresses for nodes' do
    subject { node_external_addresses }
    it { should be_empty }
  end
end
