# encoding: UTF-8

control 'eks-cis-3.2.6' do
  title 'draft'
  desc  "Protect tuned kernel parameters from overriding kubelet default kernel
parameter values."
  desc  'rationale', "Kernel parameters are usually tuned and hardened by the
system administrators before putting the systems into production. These
parameters protect the kernel and the system. Your kubelet kernel defaults that
rely on such parameters should be appropriately set to match the desired
secured system state. Ignoring this could potentially lead to running pods with
undesired kernel behavior."
  desc  'check', "
    **Audit Method 1:**

    If using a Kubelet configuration file, check that there is an entry for
`protectKernelDefaults` is set to `true`.

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

    Verify that the `--protect-kernel-defaults=true`.

    If the `--protect-kernel-defaults` argument is not present, check that
there is a Kubelet config file specified by `--config`, and that the file sets
`protectKernelDefaults` to `true`.

    **Audit Method 2:**

    If using the api configz endpoint consider searching for the status of
`\"protectKernelDefaults\"` by extracting the live configuration from the nodes
running kubelet.

    Set the local proxy port and the following variables and provide proxy port
number and node name;
    `HOSTNAME_PORT=\"localhost-and-port-number\"`
    `NODE_NAME=\"The-Name-Of-Node-To-Extract-Configuration\" from the output of
\"kubectl get nodes\"`
    ```
    kubectl proxy --port=8001 &

    export HOSTNAME_PORT=localhost:8001 (example host and port number)
    export NODE_NAME=ip-192.168.31.226.ec2.internal (example node name from
\"kubectl get nodes\")

    curl -sSL
\"http://${HOSTNAME_PORT}/api/v1/nodes/${NODE_NAME}/proxy/configz\"
    ```
  "
  desc  'fix', "
    **Remediation Method 1:**

    If modifying the Kubelet config file, edit the kubelet-config.json file
`/etc/kubernetes/kubelet/kubelet-config.json` and set the below parameter to
true

    ```
    \"protectKernelDefaults\":
    ```

    **Remediation Method 2:**

    If using a Kubelet config file, edit the file to set
`protectKernelDefaults` to `true`.

    If using executable arguments, edit the kubelet service file
`/etc/systemd/system/kubelet.service.d/10-kubelet-args.conf` on each worker
node and add the below parameter at the end of the `KUBELET_ARGS` variable
string.

    ```
    ----protect-kernel-defaults=true
    ```

    **Remediation Method 3:**

    If using the api configz endpoint consider searching for the status of
`\"protectKernelDefaults\":` by extracting the live configuration from the
nodes running kubelet.

    **See detailed step-by-step configmap procedures in [Reconfigure a Node's
Kubelet in a Live
Cluster](https://kubernetes.io/docs/tasks/administer-cluster/reconfigure-kubelet/),
and then rerun the curl statement from audit process to check for kubelet
configuration changes
    ```
    kubectl proxy --port=8001 &

    export HOSTNAME_PORT=localhost:8001 (example host and port number)
    export NODE_NAME=ip-192.168.31.226.ec2.internal (example node name from
\"kubectl get nodes\")

    curl -sSL
\"http://${HOSTNAME_PORT}/api/v1/nodes/${NODE_NAME}/proxy/configz\"
    ```

    **For all three remediations:**
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
  tag cis_rid: '3.2.6'
end

