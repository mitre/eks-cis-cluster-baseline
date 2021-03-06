control 'eks-cis-4.3.1' do
  title 'Ensure latest CNI version is used'
  desc  "There are a variety of CNI plugins available for Kubernetes. If the
CNI in use does not support Network Policies it may not be possible to
effectively restrict traffic in the cluster."
  desc  'rationale', "Kubernetes network policies are enforced by the CNI
plugin in use. As such it is important to ensure that the CNI plugin supports
both Ingress and Egress network policies."
  desc  'check', "Review the documentation of CNI plugin in use by the cluster,
and confirm that it supports network policies."
  desc  'fix', "As with RBAC policies, network policies should adhere to the
policy of least privileged access. Start by creating a deny all policy that
restricts all inbound and outbound traffic from a namespace or create a global
policy using Calico."
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['SI-2']
  tag cis_level: 1
  tag cis_controls: [
    { '6' => ['5.1'] },
    { '7' => ['5.2'] }
  ]
  tag cis_rid: '4.3.1'

  describe 'Manual control' do
    skip 'Manual review of the documentation of the CNI plugin in use is required'
  end
end
