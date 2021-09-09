# encoding: UTF-8

control 'eks-cis-4.1.6' do
  title 'draft'
  desc  "Service accounts tokens should not be mounted in pods except where the
workload running in the pod explicitly needs to communicate with the API server"
  desc  'rationale', "
    Mounting service account tokens inside pods can provide an avenue for
privilege escalation attacks where an attacker is able to compromise a single
pod in the cluster.

    Avoiding mounting these tokens removes this attack avenue.
  "
  desc  'check', "
    Review pod and service account objects in the cluster and ensure that the
option below is set, unless the resource explicitly requires this access.

    ```
    automountServiceAccountToken: false
    ```
  "
  desc  'fix', "Modify the definition of pods and service accounts which do not
need to mount service account tokens to disable it."
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
  tag cis_rid: '4.1.6'
end

