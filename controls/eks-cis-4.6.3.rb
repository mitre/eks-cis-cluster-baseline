# encoding: UTF-8

control 'eks-cis-4.6.3' do
  title 'The default namespace should not be used'
  desc  "Kubernetes provides a default namespace, where objects are placed if
no namespace is specified for them. Placing objects in this namespace makes
application of RBAC and other controls more difficult."
  desc  'rationale', "Resources in a Kubernetes cluster should be segregated by
namespace, to allow for security controls to be applied at that level and to
make it easier to manage resources."
  desc  'check', "
    Run this command to list objects in default namespace

    ```
    kubectl get all -n default
    ```

    The only entries there should be system managed resources such as the
`kubernetes` service
  "
  desc  'fix', "Ensure that namespaces are created to allow for appropriate
segregation of Kubernetes resources and that all new resources are created in a
specific namespace."
  impact 0.7
  tag severity: 'high'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['CM-6', 'Rev_4']
  tag cis_level: 2
  tag cis_controls: ['5.1', 'Rev_7']
  tag cis_rid: '4.6.3'

  default_namespace_objects = command(
    "kubectl get all -n default -o=custom-columns=':.metadata.name' --no-headers"
  ).stdout.split

  describe "Only default objects should be present in the default namespace -- list of objects in the default namespace" do
    subject{ default_namespace_objects }
    it { should eq ["kubernetes"] }
  end
end

