control 'eks-cis-4.2.6' do
  title 'Minimize the admission of root containers'
  desc  'Do not generally permit containers to be run as the root user.'
  desc  'rationale', "
    Containers may run as any Linux user. Containers which run as the root
user, whilst constrained by Container Runtime security features still have a
escalated likelihood of container breakout.

    Ideally, all containers should run as a defined non-UID 0 user.

    There should be at least one PodSecurityPolicy (PSP) defined which does not
permit root users in a container.

    If you need to run root containers, this should be defined in a separate
PSP and you should carefully check RBAC controls to ensure that only limited
service accounts and users are given permission to access that PSP.
  "
  desc  'check', "
    Get the set of PSPs with the following command:

    ```
    kubectl get psp
    ```

    For each PSP, check whether running containers as root is enabled:

    ```
    kubectl get psp <name> -o=jsonpath='{.spec.runAsUser.rule}'
    ```

    Verify that there is at least one PSP which returns `MustRunAsNonRoot` or
`MustRunAs` with the range of UIDs not including 0.
  "
  desc 'fix', "Create a PSP as described in the Kubernetes documentation,
ensuring that the `.spec.runAsUser.rule` is set to either `MustRunAsNonRoot` or
`MustRunAs` with the range of UIDs not including 0."
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['AC-6 (9)', 'CM-2']
  tag cis_level: 1
  tag cis_controls: [
    { '6' => ['5.1'] },
    { '7' => ['5.2'] }
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
