control 'eks-cis-4.6.2' do
  title 'Apply Security Context to Your Pods and Containers'
  desc  'Apply Security Context to Your Pods and Containers'
  desc  'rationale', "A security context defines the operating system security
settings (uid, gid, capabilities, SELinux role, etc..) applied to a container.
When designing your containers and pods, make sure that you configure the
security context for your pods, containers, and volumes. A security context is
a property defined in the deployment yaml. It controls the security parameters
that will be assigned to the pod/container/volume. There are two levels of
security context: pod level security context, and container level security
context."
  desc  'check', "Review the pod definitions in your cluster and verify that
you have security contexts defined as appropriate."
  desc  'fix', "
    As a best practice we recommend that you scope the binding for privileged
pods to service accounts within a particular namespace, e.g. kube-system, and
limiting access to that namespace. For all other serviceaccounts/namespaces, we
recommend implementing a more restrictive policy such as this:

    ```
    apiVersion: policy/v1beta1
    kind: PodSecurityPolicy
    metadata:
     name: restricted
     annotations:
     seccomp.security.alpha.kubernetes.io/allowedProfileNames:
'docker/default,runtime/default'
     apparmor.security.beta.kubernetes.io/allowedProfileNames: 'runtime/default'
     seccomp.security.alpha.kubernetes.io/defaultProfileName: 'runtime/default'
     apparmor.security.beta.kubernetes.io/defaultProfileName: 'runtime/default'
    spec:
     privileged: false
     # Required to prevent escalations to root.
     allowPrivilegeEscalation: false
     # This is redundant with non-root + disallow privilege escalation,
     # but we can provide it for defense in depth.
     requiredDropCapabilities:
     - ALL
     # Allow core volume types.
     volumes:
     - 'configMap'
     - 'emptyDir'
     - 'projected'
     - 'secret'
     - 'downwardAPI'
     # Assume that persistentVolumes set up by the cluster admin are safe to
use.
     - 'persistentVolumeClaim'
     hostNetwork: false
     hostIPC: false
     hostPID: false
     runAsUser:
     # Require the container to run without root privileges.
     rule: 'MustRunAsNonRoot'
     seLinux:
     # This policy assumes the nodes are using AppArmor rather than SELinux.
     rule: 'RunAsAny'
     supplementalGroups:
     rule: 'MustRunAs'
     ranges:
     # Forbid adding the root group.
     - min: 1
     max: 65535
     fsGroup:
     rule: 'MustRunAs'
     ranges:
     # Forbid adding the root group.
     - min: 1
     max: 65535
     readOnlyRootFilesystem: false
    ```

    This policy prevents pods from running as privileged or escalating
privileges. It also restricts the types of volumes that can be mounted and the
root supplemental groups that can be added.

    Another, albeit similar, approach is to start with policy that locks
everything down and incrementally add exceptions for applications that need
looser restrictions such as logging agents which need the ability to mount a
host path.
  "
  impact 0.7
  tag severity: 'high'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: %w(RA-5 Rev_4)
  tag cis_level: 2
  tag cis_controls: %w(3 Rev_6)
  tag cis_rid: '4.6.2'

  describe 'Manual control' do
    skip 'Manual review of which security policies are applied to which pods is required'
  end
end
