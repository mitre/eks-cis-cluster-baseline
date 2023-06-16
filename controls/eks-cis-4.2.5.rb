control 'eks-cis-4.2.5' do
  title 'Minimize the admission of containers with
  allowPrivilegeEscalation'
  desc  "Do not generally permit containers to be run with the allowPrivilegeEscalation flag set to true. Allowing this right can lead to a process running a container getting more rights than it started with.
It's important to note that these rights are still constrained by the overall container sandbox, and this setting does not relate to the use of privileged containers."
  desc  'rationale', "
A container running with the allowPrivilegeEscalation flag set to true may have processes that can gain more privileges than their parent.
There should be at least one admission control policy defined which does not permit containers to allow privilege escalation. The option exists (and is defaulted to true) to permit setuid binaries to run.
If you have need to run containers which use setuid binaries or require privilege escalation, this should be defined in a separate policy and you should carefully check to ensure that only limited service accounts and users are given permission to use that policy.  "
  desc  'check', "
List the policies in use for each namespace in the cluster, ensure that each policy disallows the admission of containers which allow privilege escalation.
  "
  desc 'fix', "Add policies to each namespace in the cluster which has user workloads to restrict the admission of containers with .spec.allowPrivilegeEscalation set to true."
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
  tag cis_rid: '4.2.5'

  k = command('kubectl get psp -o json')
  psp = json(content: k.stdout)

  describe.one do
    psp.items.each do |policy|
      describe "Pod security policy \"#{policy['metadata']['name']}\"" do
        subject { policy }
        its(['spec', 'allowPrivilegeEscalation']) { should_not eq true }
      end
    end
  end
end
