control 'eks-cis-4.2.6' do
  title 'Minimize the admission of root containers'
  desc  'Do not generally permit containers to be run as the root user.'
  desc  'rationale', "
Containers may run as any Linux user. Containers which run as the root user, whilst constrained by Container Runtime security features still have a escalated likelihood of container breakout.
Ideally, all containers should run as a defined non-UID 0 user.
There should be at least one admission control policy defined which does not permit root containers.
If you need to run root containers, this should be defined in a separate policy and you should carefully check to ensure that only limited service accounts and users are given permission to use that policy.  "
  desc  'check', "
List the policies in use for each namespace in the cluster, ensure that each policy restricts the use of root containers by setting MustRunAsNonRoot or MustRunAs with the range of UIDs not including 0.
  "
  desc 'fix', "Create a policy for each namespace in the cluster, ensuring that either MustRunAsNonRoot or MustRunAs with the range of UIDs not including 0, is set."
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
  tag cis_rid: '4.2.6'

  k = command('kubectl get psp -o json')
  psp = json(content: k.stdout)

  describe.one do
    psp.items.each do |policy|
      describe "Pod security policy \"#{policy['metadata']['name']}\"" do
        it 'should not allow pods to run as root' do
          expect(policy['spec']['runAsUser']['rule']).to satisfy { |userRule|
            userRule == 'MustRunAs' ? userRule['ranges']['min'] > 0 : userRule == 'MustRunAsNonRoot'
          }
        end
      end
    end
  end
end
