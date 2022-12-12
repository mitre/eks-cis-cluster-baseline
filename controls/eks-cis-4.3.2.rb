control 'eks-cis-4.3.2' do
  title 'Ensure that all Namespaces have Network Policies defined'
  desc  'Use network policies to isolate traffic in your cluster network.'
  desc  'rationale', "
    Running different applications on the same Kubernetes cluster creates a
risk of one compromised application attacking a neighboring application.
Network segmentation is important to ensure that containers can communicate
only with those they are supposed to. A network policy is a specification of
how selections of pods are allowed to communicate with each other and other
network endpoints.

    Network Policies are namespace scoped. When a network policy is introduced
to a given namespace, all traffic not allowed by the policy is denied. However,
if there are no network policies in a namespace all traffic will be allowed
into and out of the pods in that namespace.
  "
  desc  'check', "
    Run the below command and review the `NetworkPolicy` objects created in the
cluster.

    ```
    kubectl get networkpolicy --all-namespaces
    ```

    Ensure that each namespace defined in the cluster has at least one Network
Policy.
  "
  desc 'fix', "Follow the documentation and create `NetworkPolicy` objects as
you need them."
  impact 0.7
  tag severity: 'high'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: %w(AC-4 Rev_4)
  tag cis_level: 2
  tag cis_controls: ['14.1', 'Rev_6']
  tag cis_rid: '4.3.2'

  namespaces = command('kubectl get namespace -o=custom-columns=:.metadata.name --no-headers').stdout.split

  if namespaces != []
    # filter for the namespaces that do not have a defined network policy (i.e. checking for the policy returns empty string)
    noncompliant_namespaces = namespaces.filter_map { |namespace| 
      namespace if command(
        "kubectl get networkpolicy -n #{namespace} -o=custom-columns=:.metadata.name --no-headers"
      ).stdout == ""
    }
    describe "Each namespace" do
      it "should have a defined network policy" do 
        fail_msg = "Namespaces with missing network policies: #{noncompliant_namespaces}"
        expect(noncompliant_namespaces).to be_empty, fail_msg
      end
    end
  else
    describe 'No namespaces defined' do
      subject { namespaces }
      it { should_not eq [] }
    end
  end
end
