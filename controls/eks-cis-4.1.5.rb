# encoding: UTF-8

control 'eks-cis-4.1.5' do
  title 'draft'
  desc  "The `default` service account should not be used to ensure that rights
granted to applications can be more easily audited and reviewed."
  desc  'rationale', "
    Kubernetes provides a `default` service account which is used by cluster
workloads where no specific service account is assigned to the pod.

    Where access to the Kubernetes API from a pod is required, a specific
service account should be created for that pod, and rights granted to that
service account.

    The default service account should be configured such that it does not
provide a service account token and does not have any explicit rights
assignments.
  "
  desc  'check', "
    For each namespace in the cluster, review the rights assigned to the
default service account and ensure that it has no roles or cluster roles bound
to it apart from the defaults.

    Additionally ensure that the `automountServiceAccountToken: false` setting
is in place for each default service account.
  "
  desc  'fix', "
    Create explicit service accounts wherever a Kubernetes workload requires
specific access to the Kubernetes API server.

    Modify the configuration of each default service account to include this
value

    ```
    automountServiceAccountToken: false
    ```

    Automatic remediation for the default account:

    `kubectl patch serviceaccount default -p $'automountServiceAccountToken:
false'`
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['CM-2', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['5.2', 'Rev_7']
  tag cis_rid: '4.1.5'
end

