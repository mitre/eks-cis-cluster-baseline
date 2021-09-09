# encoding: UTF-8

control 'eks-cis-4.1.2' do
  title 'draft'
  desc  "The Kubernetes API stores secrets, which may be service account tokens
for the Kubernetes API or credentials used by workloads in the cluster. Access
to these secrets should be restricted to the smallest possible group of users
to reduce the risk of privilege escalation."
  desc  'rationale', "Inappropriate access to secrets stored within the
Kubernetes cluster can allow for an attacker to gain additional access to the
Kubernetes cluster or external resources whose credentials are stored as
secrets."
  desc  'check', "Review the users who have `get`, `list` or `watch` access to
`secrets` objects in the Kubernetes API."
  desc  'fix', "Where possible, remove `get`, `list` and `watch` access to
`secret` objects in the cluster."
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['CM-2', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['5.2', 'Rev_7']
  tag cis_rid: '4.1.2'
end

