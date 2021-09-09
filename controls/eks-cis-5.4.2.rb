# encoding: UTF-8

control 'eks-cis-5.4.2' do
  title 'draft'
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
end

