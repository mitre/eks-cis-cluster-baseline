# encoding: UTF-8

control 'eks-cis-4.2.7' do
  title 'draft'
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
  desc  'fix', "Create a PSP as described in the Kubernetes documentation,
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
  tag nist: ['CM-6', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['5.1', 'Rev_6']
  tag cis_rid: '4.2.7'
end

