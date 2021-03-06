control 'eks-cis-4.2.7' do
  title 'Minimize the admission of containers with the NET_RAW
  capability'
  desc  "Do not generally permit containers with the potentially dangerous
NET_RAW capability."
  desc  'rationale', "
    Containers run with a default set of capabilities as assigned by the
Container Runtime. By default this can include potentially dangerous
capabilities. With Docker as the container runtime the NET_RAW capability is
enabled which may be misused by malicious containers.

    Ideally, all containers should drop this capability.

    There should be at least one PodSecurityPolicy (PSP) defined which prevents
containers with the NET_RAW capability from launching.

    If you need to run containers with this capability, this should be defined
in a separate PSP and you should carefully check RBAC controls to ensure that
only limited service accounts and users are given permission to access that PSP.
  "
  desc  'check', "
    Get the set of PSPs with the following command:

    ```
    kubectl get psp
    ```

    For each PSP, check whether NET_RAW is disabled:

    ```
    kubectl get psp <name> -o=jsonpath='{.spec.requiredDropCapabilities}'
    ```

    Verify that there is at least one PSP which returns NET_RAW or ALL.
  "
  desc 'fix', "Create a PSP as described in the Kubernetes documentation,
ensuring that the `.spec.requiredDropCapabilities` is set to include either
`NET_RAW` or `ALL`."
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
  tag cis_rid: '4.2.7'

  k = command('kubectl get psp -o json')
  psp = json(content: k.stdout)

  describe.one do
    psp.items.each do |policy|
      describe "Pod security policy \"#{policy['metadata']['name']}\"" do
        subject { policy }
        its(['spec', 'requiredDropCapabilities']) { should be_in ['NET_RAW', 'ALL'] }
      end
    end
  end
end
