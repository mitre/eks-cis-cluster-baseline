control 'eks-cis-5.2.1' do
  title 'Prefer using dedicated EKS Service Accounts'
  desc  "Kubernetes workloads should not use cluster node service accounts to
authenticate to Amazon EKS APIs. Each Kubernetes workload that needs to
authenticate to other AWS services using AWS IAM should be provisioned with a
dedicated Service account."
  desc  'rationale', "Manual approaches for authenticating Kubernetes workloads
running on Amazon EKS against AWS APIs are: storing service account keys as a
Kubernetes secret (which introduces manual key rotation and potential for key
compromise); or use of the underlying nodes' IAM Service account, which
violates the principle of least privilege on a multi-tenanted node, when one
pod needs to have access to a service, but every other pod on the node that
uses the Service account does not."
  desc  'check', "
    For each namespace in the cluster, review the rights assigned to the
default service account and ensure that it has no roles or cluster roles bound
to it apart from the defaults.

    Additionally ensure that the automountServiceAccountToken: false setting is
in place for each default service account.
  "
  desc 'fix', "
    With IAM roles for service accounts on Amazon EKS clusters, you can
associate an IAM role with a Kubernetes service account. This service account
can then provide AWS permissions to the containers in any pod that uses that
service account. With this feature, you no longer need to provide extended
permissions to the worker node IAM role so that pods on that node can call AWS
APIs.

    Applications must sign their AWS API requests with AWS credentials. This
feature provides a strategy for managing credentials for your applications,
similar to the way that Amazon EC2 instance profiles provide credentials to
Amazon EC2 instances. Instead of creating and distributing your AWS credentials
to the containers or using the Amazon EC2 instance’s role, you can associate an
IAM role with a Kubernetes service account. The applications in the pod’s
containers can then use an AWS SDK or the AWS CLI to make API requests to
authorized AWS services.

    The IAM roles for service accounts feature provides the following benefits:

    - Least privilege — By using the IAM roles for service accounts feature,
you no longer need to provide extended permissions to the worker node IAM role
so that pods on that node can call AWS APIs. You can scope IAM permissions to a
service account, and only pods that use that service account have access to
those permissions. This feature also eliminates the need for third-party
solutions such as kiam or kube2iam.
    - Credential isolation — A container can only retrieve credentials for the
IAM role that is associated with the service account to which it belongs. A
container never has access to credentials that are intended for another
container that belongs to another pod.
    - Auditability — Access and event logging is available through CloudTrail
to help ensure retrospective auditing.

    To get started, see [Enabling IAM roles for service accounts on your
cluster.](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html)

    For an end-to-end walkthrough using eksctl, see [Walkthrough: Updating a
DaemonSet to use IAM for service
accounts](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts-cni-walkthrough.html).
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: ['AC-6 (9)']
  tag cis_level: 1
  tag cis_controls: [
    { '7' => ['4.3'] }
  ]
  tag cis_rid: '5.2.1'

  describe 'Manual control' do
    skip 'Manual review is required to ensure any namespace default service accounts have no excessive roles'
  end
end
