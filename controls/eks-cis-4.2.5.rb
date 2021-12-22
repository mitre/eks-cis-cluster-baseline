# encoding: UTF-8

control 'eks-cis-4.2.5' do
  title 'Minimize the admission of containers with
  allowPrivilegeEscalation'
  desc  "Do not generally permit containers to be run with the
`allowPrivilegeEscalation` flag set to true."
  desc  'rationale', "
    A container running with the `allowPrivilegeEscalation` flag set to `true`
may have processes that can gain more privileges than their parent.

    There should be at least one PodSecurityPolicy (PSP) defined which does not
permit containers to allow privilege escalation. The option exists (and is
defaulted to true) to permit setuid binaries to run.

    If you have need to run containers which use setuid binaries or require
privilege escalation, this should be defined in a separate PSP and you should
carefully check RBAC controls to ensure that only limited service accounts and
users are given permission to access that PSP.
  "
  desc  'check', "
    Get the set of PSPs with the following command:

    ```
    kubectl get psp
    ```

    For each PSP, check whether privileged is enabled:

    ```
    kubectl get psp <name> -o=jsonpath='{.spec.allowPrivilegeEscalation}'
    ```

    Verify that there is at least one PSP which does not return true.
  "
  desc  'fix', "Create a PSP as described in the Kubernetes documentation,
ensuring that the `.spec.allowPrivilegeEscalation` field is omitted or set to
false."
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['CM-6', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['5.1', 'Rev_6']
  tag cis_rid: '4.2.5'

  k = command("kubectl get psp -o json")
  psp = json(content: k.stdout)

  describe.one do
    psp.items.each do |policy|
      describe "Pod security policy \"#{policy['metadata']['name']}\"" do
        subject { policy }
        its(['spec', 'allowPrivilegeEscalation']) { should_not be true }
      end
    end
  end
end

