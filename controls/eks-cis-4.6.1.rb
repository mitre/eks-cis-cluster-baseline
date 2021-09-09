# encoding: UTF-8

control 'eks-cis-4.6.1' do
  title 'draft'
  desc  'Use namespaces to isolate your Kubernetes objects.'
  desc  'rationale', "Limiting the scope of user permissions can reduce the
impact of mistakes or malicious activities. A Kubernetes namespace allows you
to partition created resources into logically named groups. Resources created
in one namespace can be hidden from other namespaces. By default, each resource
created by a user in an Amazon EKS cluster runs in a default namespace, called
`default`. You can create additional namespaces and attach resources and users
to them. You can use Kubernetes Authorization plugins to create policies that
segregate access to namespace resources between different users."
  desc  'check', "
    Run the below command and review the namespaces created in the cluster.

    ```
    kubectl get namespaces
    ```

    Ensure that these namespaces are the ones you need and are adequately
administered as per your requirements.
  "
  desc  'fix', "Follow the documentation and create namespaces for objects in
your deployment as you need them."
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['AC-6', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['14', 'Rev_6']
  tag cis_rid: '4.6.1'
end

