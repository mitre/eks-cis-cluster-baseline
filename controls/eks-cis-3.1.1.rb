# encoding: UTF-8

control 'eks-cis-3.1.1' do
  title 'draft'
  desc  "If `kubelet` is running, and if it is using a file-based kubeconfig
file, ensure that the proxy kubeconfig file has permissions of `644` or more
restrictive."
  desc  'rationale', "
    The `kubelet` kubeconfig file controls various parameters of the `kubelet`
service in the worker node. You should restrict its file permissions to
maintain the integrity of the file. The file should be writable by only the
administrators on the system.

    It is possible to run `kubelet` with the kubeconfig parameters configured
as a Kubernetes ConfigMap instead of a file. In this case, there is no proxy
kubeconfig file.
  "
  desc  'check', "
    SSH to the worker nodes

    To check to see if the Kubelet Service is running:
    ```
    sudo systemctl status kubelet
    ```
    The output should return `Active: active (running) since..`

    Run the following command on each node to find the appropriate kubeconfig
file:

    ```
    ps -ef | grep kubelet
    ```
    The output of the above command should return something similar to
`--kubeconfig /var/lib/kubelet/kubeconfig` which is the location of the
kubeconfig file.

    Run this command to obtain the kubeconfig file permissions:

    ```
    stat -c %a /var/lib/kubelet/kubeconfig
    ```
    The output of the above command gives you the kubeconfig file's permissions.

    Verify that if a file is specified and it exists, the permissions are `644`
or more restrictive.
  "
  desc  'fix', "
    Run the below command (based on the file location on your system) on the
each worker
    node. For example,
    ```
    chmod 644 <kubeconfig file>
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
  tag nist: ['CM-6', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['5.1', 'Rev_6']
  tag cis_rid: '3.1.1'
end

