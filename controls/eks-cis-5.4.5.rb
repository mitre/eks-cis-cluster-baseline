control 'eks-cis-5.4.5' do
  title 'Encrypt traffic to HTTPS load balancers with TLS certificates'
  desc  'Encrypt traffic to HTTPS load balancers using TLS certificates.'
  desc  'rationale', "Encrypting traffic between users and your Kubernetes
workload is fundamental to protecting data sent over the web."
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
  tag nist: ['SC-8']
  tag cis_level: 2
  tag cis_controls: [
    { '7' => ['14.4'] }
  ]
  tag cis_rid: '5.4.5'

  describe 'Manual control' do
    skip 'Manual review is required to ensure TLS is properly configured'
  end
end
