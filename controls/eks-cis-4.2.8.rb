control 'eks-cis-4.2.8' do
  title 'Minimize the admission of containers with capabilities assigned'
  desc  'Do not generally permit containers with capabilities'
  desc  'rationale', "
    Containers run with a default set of capabilities as assigned by the
Container Runtime. Capabilities are parts of the rights generally granted on a
Linux system to the root user.

    In many cases applications running in containers do not require any
capabilities to operate, so from the perspective of the principal of least
privilege use of capabilities should be minimized.
  "
  desc  'check', "
List the policies in use for each namespace in the cluster, ensure that at least one policy requires that capabilities are dropped by all containers.  "
  desc 'fix', "Review the use of capabilities in applications running on your cluster. Where a namespace contains applications which do not require any Linux capabilities to operate consider adding a policy which forbids the admission of containers which do not drop all capabilities."
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
  tag cis_rid: '4.2.8'

  unless input("alternative_policy_enforcement")
    k = command(
      "kubectl get ns --selector=pod-security.kubernetes.io/enforce!=restricted -o jsonpath=\'{.items[*].metadata.name}\'"
    ).stdout.strip.split(' ') - input("allowed_namespaces_privileged") - input("allowed_namespaces_baseline")

    describe "List of namespaces with a pod security admission policy (PSA) which does not force containers to drop all Linux capabilities" do
      subject { k }
      it { should be_empty }
    end
  else
    describe "Third-party policy enforcement in use" do
      skip "Input set to indicate use of third-party policy enforcement mechanism; manually review third-party policy enforcement method to ensure compliance with security policies"
    end
  end
end
