# encoding: UTF-8

control 'eks-cis-5.1.4' do
  title 'draft'
  desc  'Use approved container registries.'
  desc  'rationale', "Allowing unrestricted access to external container
registries provides the opportunity for malicious or unapproved containers to
be deployed into the cluster. Allowlisting only approved container registries
reduces this risk."
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
  tag nist: ['CM-2', 'Rev_4']
  tag cis_level: 2
  tag cis_controls: ['5.2', 'Rev_7']
  tag cis_rid: '5.1.4'
end

