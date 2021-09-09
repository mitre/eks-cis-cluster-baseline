# encoding: UTF-8

control 'eks-cis-4.2.8' do
  title 'draft'
  desc  "Do not generally permit containers with capabilities assigned beyond
the default set."
  desc  'rationale', "
    Containers run with a default set of capabilities as assigned by the
Container Runtime. Capabilities outside this set can be added to containers
which could expose them to risks of container breakout attacks.

    There should be at least one PodSecurityPolicy (PSP) defined which prevents
containers with capabilities beyond the default set from launching.

    If you need to run containers with additional capabilities, this should be
defined in a separate PSP and you should carefully check RBAC controls to
ensure that only limited service accounts and users are given permission to
access that PSP.
  "
  desc  'check', "
    Get the set of PSPs with the following command:

    ```
    kubectl get psp
    ```

    Verify that there are no PSPs present which have `allowedCapabilities` set
to anything other than an empty array.
  "
  desc  'fix', "Ensure that `allowedCapabilities` is not present in PSPs for
the cluster unless it is set to an empty array."
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
  tag cis_rid: '4.2.8'
end

