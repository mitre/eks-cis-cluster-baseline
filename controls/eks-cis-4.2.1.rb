control 'eks-cis-4.2.1' do
  title 'Minimize the admission of privileged containers'
  desc  "Do not generally permit containers to be run with the
`securityContext.privileged` flag set to `true`."
  desc  'rationale', "
    Privileged containers have access to all Linux Kernel capabilities and
devices. A container running with full privileges can do almost everything that
the host can do. This flag exists to allow special use-cases, like manipulating
the network stack and accessing devices.

    There should be at least one PodSecurityPolicy (PSP) defined which does not
permit privileged containers.

    If you need to run privileged containers, this should be defined in a
separate PSP and you should carefully check RBAC controls to ensure that only
limited service accounts and users are given permission to access that PSP.
  "
  desc  'check', "
    Get the set of PSPs with the following command:

    ```
    kubectl get psp
    ```

    For each PSP, check whether privileged is enabled:

    ```
    kubectl get psp -o json
    ```

    Verify that there is at least one PSP which does not return `true`.

    `kubectl get psp <name> -o=jsonpath='{.spec.privileged}'`
  "
  desc 'fix', "Create a PSP as described in the Kubernetes documentation,
ensuring that the `.spec.privileged` field is omitted or set to `false`."
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
  tag cis_rid: '4.2.1'

  k = command('kubectl get psp -o json')
  psp = json(content: k.stdout)

  describe.one do
    psp.items.each do |policy|
      describe "Pod security policy \"#{policy['metadata']['name']}\"" do
        subject { policy }
        its(['spec', 'privileged']) { should_not eq true }
      end
    end
  end
end
