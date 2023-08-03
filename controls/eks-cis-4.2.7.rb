control 'eks-cis-4.2.7' do
  title 'Minimize the admission of containers with added capabilities'
  desc  "Do not generally permit containers with capabilities assigned beyond
the default set."
  desc  'rationale', "
Containers run with a default set of capabilities as assigned by the Container Runtime. Capabilities outside this set can be added to containers which could expose them to risks of container breakout attacks.
There should be at least one policy defined which prevents containers with capabilities beyond the default set from launching.
If you need to run containers with additional capabilities, this should be defined in a separate policy and you should carefully check to ensure that only limited service accounts and users are given permission to use that policy.
  "
  desc  'check', "
List the policies in use for each namespace in the cluster, ensure that policies are present which prevent allowedCapabilities to be set to anything other than an empty array.  "
  desc 'fix', "Ensure that allowedCapabilities is not present in policies for the cluster unless it is set to an empty array."
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
  tag cis_rid: '4.2.7'

  unless input("alternative_policy_enforcement")
    k = command(
      "kubectl get ns --selector=pod-security.kubernetes.io/enforce!=restricted -o jsonpath=\'{.items[*].metadata.name}\'"
    ).stdout.strip.split(' ') - input("allowed_namespaces_privileged") - input("allowed_namespaces_baseline")

    describe "List of namespaces with a pod security admission policy (PSA) which allows containers to set Linux capabilities" do
      subject { k }
      it { should be_empty }
    end
  else
    describe "Third-party policy enforcement in use" do
      skip "Input set to indicate use of third-party policy enforcement mechanism; manually review third-party policy enforcement method to ensure compliance with security policies"
    end
  end
end
