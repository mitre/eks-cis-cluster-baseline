# encoding: UTF-8

control 'eks-cis-4.5.1' do
  title 'draft'
  desc  'Configure Image Provenance for your deployment.'
  desc  'rationale', "Kubernetes supports plugging in provenance rules to
accept or reject the images in your deployments. You could configure such rules
to ensure that only approved images are deployed in the cluster."
  desc  'check', "Review the pod definitions in your cluster and verify that
image provenance is configured as appropriate."
  desc  'fix', 'Follow the Kubernetes documentation and setup image provenance.'
  impact 0.7
  tag severity: 'high'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['AC-6', 'Rev_4']
  tag cis_level: 2
  tag cis_controls: ['18', 'Rev_6']
  tag cis_rid: '4.5.1'
end

