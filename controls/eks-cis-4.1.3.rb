control 'eks-cis-4.1.3' do
  title 'Minimize wildcard use in Roles and ClusterRoles'
  desc  "Kubernetes Roles and ClusterRoles provide access to resources based on
sets of objects and actions that can be taken on those objects. It is possible
to set either of these to be the wildcard \"*\" which matches all items.

    Use of wildcards is not optimal from a security perspective as it may allow
for inadvertent access to be granted when new resources are added to the
Kubernetes API either as CRDs or in later versions of the product.
  "
  desc  'rationale', "The principle of least privilege recommends that users
are provided only the access required for their role and nothing more. The use
of wildcard rights grants is likely to provide excessive rights to the
Kubernetes API."
  desc  'check', "
    Retrieve the roles defined across each namespaces in the cluster and review
for wildcards

    ```
    kubectl get roles --all-namespaces -o yaml
    ```

    Retrieve the cluster roles defined in the cluster and review for wildcards

    ```
    kubectl get clusterroles -o yaml
    ```
  "
  desc 'fix', "Where possible replace any use of wildcards in clusterroles and
roles with specific objects or actions."
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['CM-6']
  tag cis_level: 1
  tag cis_controls: [
    { '7' => ['5.1'] }
  ]
  tag cis_rid: '4.1.3'

  describe 'Manual control' do
    skip "Manual review of roles and cluster roles should be conducted to ensure there are no roles with wildcard ('*') permissions"
  end
end
