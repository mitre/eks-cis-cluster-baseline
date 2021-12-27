control 'eks-cis-4.4.1' do
  title 'Prefer using secrets as files over secrets as environment variables'
  desc  "Kubernetes supports mounting secrets as data volumes or as environment
variables. Minimize the use of environment variable secrets."
  desc  'rationale', "It is reasonably common for application code to log out
its environment (particularly in the event of an error). This will include any
secret values passed in as environment variables, so secrets can easily be
exposed to any user or entity who has access to the logs."
  desc  'check', "
    Run the following command to find references to objects which use
environment variables defined from secrets.

    ```
    kubectl get all -o jsonpath='{range .items[?(@..secretKeyRef)]} {.kind}
{.metadata.name} {\"\
    \"}{end}' -A
    ```
  "
  desc  'fix', "If possible, rewrite application code to read secrets from
mounted secret files, rather than from environment variables."
  impact 0.7
  tag severity: 'high'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: %w(SC-28 Rev_4)
  tag cis_level: 2
  tag cis_controls: ['14.8', 'Rev_7']
  tag cis_rid: '4.4.1'

  secrets_from_env = command(
    "kubectl get all -o jsonpath='{range .items[?(@..secretKeyRef)]}'"
  ).stdout

  describe 'Pods should not be setting environment variables using k8s secret objects' do
    subject { secrets_from_env }
    it { should be_empty }
  end
end
