control 'eks-cis-5.4.4' do
  title 'Ensure Network Policy is Enabled and set as appropriate'
  desc  "Use Network Policy to restrict pod to pod traffic within a cluster and
segregate workloads."
  desc  'rationale', "
    By default, all pod to pod traffic within a cluster is allowed. Network
Policy creates a pod-level firewall that can be used to restrict traffic
between sources. Pod traffic is restricted by having a Network Policy that
selects it (through the use of labels). Once there is any Network Policy in a
namespace selecting a particular pod, that pod will reject any connections that
are not allowed by any Network Policy. Other pods in the namespace that are not
selected by any Network Policy will continue to accept all traffic.

    Network Policies are managed via the Kubernetes Network Policy API and
enforced by a network plugin, simply creating the resource without a compatible
network plugin to implement it will have no effect. EKS supports Network Policy
enforcement through the use of Calico.
  "
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
  tag nist: ['CM-7 (1)', 'SC-7 (5)']
  tag cis_level: 1
  tag cis_controls: [
    { '7' => ['9.2', '9.4'] }
  ]
  tag cis_rid: '5.4.4'

  describe 'Manual control' do
    skip "Manual review of Network Policy is required to ensure it is correctly configured for the cluster's workloads"
  end
end
