# encoding: UTF-8

control 'eks-cis-4.2.6' do
  title 'draft'
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
  desc  'fix', "Create a PSP as described in the Kubernetes documentation,
ensuring that the `.spec.runAsUser.rule` is set to either `MustRunAsNonRoot` or
`MustRunAs` with the range of UIDs not including 0."
  impact 0.7
  tag severity: 'high'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['CM-6', 'Rev_4']
  tag cis_level: 2
  tag cis_controls: ['5.1', 'Rev_6']
  tag cis_rid: '4.2.6'
end

