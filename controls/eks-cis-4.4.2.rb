control 'eks-cis-4.4.2' do
  title 'Consider external secret storage'
  desc  "Consider the use of an external secrets storage and management system,
instead of using Kubernetes Secrets directly, if you have more complex secret
management needs. Ensure the solution requires authentication to access
secrets, has auditing of access to and use of secrets, and encrypts secrets.
Some solutions also make it easier to rotate secrets."
  desc  'rationale', "Kubernetes supports secrets as first-class objects, but
care needs to be taken to ensure that access to secrets is carefully limited.
Using an external secrets provider can ease the management of access to
secrets, especially where secrests are used across both Kubernetes and
non-Kubernetes environments."
  desc  'check', 'Review your secrets management implementation.'
  desc  'fix', "Refer to the secrets management options offered by your cloud
provider or a third-party secrets management solution."
  impact 0.7
  tag severity: 'high'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['SC-28']
  tag cis_level: 2
  tag cis_controls: [
    { '7' => ['14.8'] }
  ]
  tag cis_rid: '4.4.2'

  describe 'Manual control' do
    skip 'Manual review of secrets management implementation is required'
  end
end
