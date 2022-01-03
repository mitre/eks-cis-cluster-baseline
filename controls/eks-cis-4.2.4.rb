control 'eks-cis-4.2.4' do
  title 'Minimize the admission of containers wishing to share the host
  network namespace'
  desc  "Do not generally permit containers to be run with the `hostNetwork`
flag set to true."
  desc  'rationale', "
    A container running in the host's network namespace could access the local
loopback device, and could access network traffic to and from other pods.

    There should be at least one PodSecurityPolicy (PSP) defined which does not
permit containers to share the host network namespace.

    If you have need to run containers which require hostNetwork, this should
be defined in a separate PSP and you should carefully check RBAC controls to
ensure that only limited service accounts and users are given permission to
access that PSP.
  "
  desc  'check', "
    Get the set of PSPs with the following command:

    ```
    kubectl get psp
    ```

    For each PSP, check whether privileged is enabled:

    ```
    kubectl get psp <name> -o=jsonpath='{.spec.hostNetwork}'
    ```

    Verify that there is at least one PSP which does not return true.
  "
  desc 'fix', "Create a PSP as described in the Kubernetes documentation,
ensuring that the `.spec.hostNetwork` field is omitted or set to false."
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
  tag cis_rid: '4.2.4'

  k = command('kubectl get psp -o json')
  psp = json(content: k.stdout)

  describe.one do
    psp.items.each do |policy|
      describe "Pod security policy \"#{policy['metadata']['name']}\"" do
        subject { policy }
        its(['spec', 'hostNetwork']) { should_not eq true }
      end
    end
  end
end
