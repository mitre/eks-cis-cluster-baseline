# encoding: UTF-8

control 'eks-cis-4.1.1' do
  title 'Ensure that the cluster-admin role is only used where required'
  desc  "The RBAC role `cluster-admin` provides wide-ranging powers over the
environment and should be used only where and when needed."
  desc  'rationale', "Kubernetes provides a set of default roles where RBAC is
used. Some of these roles such as `cluster-admin` provide wide-ranging
privileges which should only be applied where absolutely necessary. Roles such
as `cluster-admin` allow super-user access to perform any action on any
resource. When used in a `ClusterRoleBinding`, it gives full control over every
resource in the cluster and in all namespaces. When used in a `RoleBinding`, it
gives full control over every resource in the rolebinding's namespace,
including the namespace itself."
  desc  'check', "
    Obtain a list of the principals who have access to the `cluster-admin` role
by reviewing the `clusterrolebinding` output for each role binding that has
access to the `cluster-admin` role.

    kubectl get clusterrolebindings
-o=custom-columns=NAME:.metadata.name,ROLE:.roleRef.name,SUBJECT:.subjects[*].name

    Review each principal listed and ensure that `cluster-admin` privilege is
required for it.
  "
  desc  'fix', "
    Identify all clusterrolebindings to the cluster-admin role. Check if they
are used and if they need this role or if they could use a role with fewer
privileges.

    Where possible, first bind users to a lower privileged role and then remove
the clusterrolebinding to the cluster-admin role :

    ```
    kubectl delete clusterrolebinding [name]
    ```
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['CM-6', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['5.1', 'Rev_6']
  tag cis_rid: '4.1.1'

  allowed_cluster_admin_principals = input('allowed_cluster_admin_principals')

  cluster_admin_principals = command("kubectl get clusterrolebindings cluster-admin --no-headers -o=custom-columns=':.subjects[*].name'").stdout.split("\n")

  cluster_admin_principals.each do |principal|
    describe "Cluster role bindings should restrict access to cluster-admin role" do
      subject { principal }
      it { should be_in allowed_cluster_admin_principals }
    end
  end
end

