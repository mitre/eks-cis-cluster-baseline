control 'eks-cis-4.2.1' do
  title 'Minimize the admission of privileged containers'
  desc  "Do not generally permit containers to be run with the
`securityContext.privileged` flag set to `true`."
  desc  'rationale', "
    Privileged containers have access to all Linux Kernel capabilities and
devices. A container running with full privileges can do almost everything that
the host can do. This flag exists to allow special use-cases, like manipulating
the network stack and accessing devices.

    There should be at least one admission control policy defined which does not 
permit privileged containers.

If you need to run privileged containers, this should be defined in a separate policy and 
you should carefully check to ensure that only limited service accounts and users are 
given permission to use that policy.
  "
  desc  'check', "
List the policies in use for each namespace in the cluster, ensure that each 
policy disallows the admission of privileged containers."
  desc 'fix', "Add policies to each namespace in the cluster which has user workloads to restrict the admission of privileged containers. 
To enable PSA for a namespace in your cluster, set the pod-security.kubernetes.io/enforce label with the policy value you want to enforce. 
kubectl label --overwrite ns NAMESPACE pod-security.kubernetes.io/enforce=restricted 
The above command enforces the restricted policy for the NAMESPACE namespace. 
You can also enable Pod Security Admission for all your namespaces. 
For example: kubectl label --overwrite ns --all pod-security.kubernetes.io/warn=baseline"
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['AC-6 (9)', 'AC-6 (9)', 'AC-6 (2)']
  tag cis_level: 1
  tag cis_controls: [
    { '6' => ['5.1'] },
    { '7' => ['4.3'] },
    { '8' => ['5.4'] }
  ]
  tag cis_rid: '4.2.1'

  unless input("alternative_policy_enforcement")
    k = command(
      "kubectl get ns --selector=pod-security.kubernetes.io/enforce!=restricted -o jsonpath=\'{.items[*].metadata.name}\'"
    ).stdout.strip.split(' ') - input("allowed_namespaces_privileged") - input("allowed_namespaces_baseline")

    describe "List of namespaces with a pod security admission policy (PSA) which allows privileged pods" do
      subject { k }
      it { should be_empty }
    end
  else
    describe "Third-party policy enforcement in use" do
      skip "Input set to indicate use of third-party policy enforcement mechanism; manually review third-party policy enforcement method to ensure compliance with security policies"
    end
  end
end
