# encoding: UTF-8

control 'eks-cis-5.4.3' do
  title 'draft'
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
  tag cis_controls: ['12', 'Rev_7']
  tag cis_rid: '5.4.3'
end

