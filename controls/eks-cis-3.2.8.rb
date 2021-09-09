# encoding: UTF-8

control 'eks-cis-3.2.8' do
  title 'draft'
  desc  'Do not override node hostnames.'
  desc  'rationale', "Overriding hostnames could potentially break TLS setup
between the kubelet and the apiserver. Additionally, with overridden hostnames,
it becomes increasingly difficult to associate logs with a particular node and
process them for security analytics. Hence, you should setup your kubelet nodes
with resolvable FQDNs and avoid overriding the hostnames with IPs."
  desc  'check', "
    **Audit Method 1:**

    If using a Kubelet configuration file, check that there is an entry for
`--hostname-override` is not set or does not exist.

    First, SSH to the relevant node:

    Run the following command on each node to find the appropriate Kubelet
config file:

    ```
    ps -ef | grep kubelet
    ```
    The output of the above command should return something similar to
`--config /etc/kubernetes/kubelet/kubelet-config.json` which is the location of
the Kubelet config file.

    Open the Kubelet config file:
    ```
    cat /etc/kubernetes/kubelet/kubelet-config.json
    ```

    Verify that `--hostname-override` argument does not exist.

    **Note** This setting is not configurable via the Kubelet config file.
  "
  desc  'fix', "
    **Remediation Method 1:**

    If modifying the Kubelet config file, edit the kubelet-config.json file
`/etc/kubernetes/kubelet/kubelet-config.json` and set the below parameter to
null

    ```
    \"hostname-override\"
    ```

    **Remediation Method 2:**

    If using executable arguments, edit the kubelet service file
`/etc/systemd/system/kubelet.service.d/10-kubelet-args.conf` on each worker
node and add the below parameter at the end of the `KUBELET_ARGS` variable
string.

    ```
    --hostname-override
    ```

    **For all remediations:**
    Based on your system, restart the `kubelet` service and check status

    ```
    systemctl daemon-reload
    systemctl restart kubelet.service
    systemctl status kubelet -l
    ```
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['RA-5', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['3', 'Rev_6']
  tag cis_rid: '3.2.8'
end

