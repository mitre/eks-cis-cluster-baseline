# encoding: UTF-8

control 'eks-cis-5.4.1' do
  title 'Restrict Access to the Control Plane Endpoint'
  desc  "Enable Endpoint Private Access to restrict access to the cluster's
control plane to only an allowlist of authorized IPs."
  desc  'rationale', "
    Authorized networks are a way of specifying a restricted range of IP
addresses that are permitted to access your cluster's control plane. Kubernetes
Engine uses both Transport Layer Security (TLS) and authentication to provide
secure access to your cluster's control plane from the public internet. This
provides you the flexibility to administer your cluster from anywhere; however,
you might want to further restrict access to a set of IP addresses that you
control. You can set this restriction by specifying an authorized network.

    Restricting access to an authorized network can provide additional security
benefits for your container cluster, including:

    - Better protection from outsider attacks: Authorized networks provide an
additional layer of security by limiting external access to a specific set of
addresses you designate, such as those that originate from your premises. This
helps protect access to your cluster in the case of a vulnerability in the
cluster's authentication or authorization mechanism.
    - Better protection from insider attacks: Authorized networks help protect
your cluster from accidental leaks of master certificates from your company's
premises. Leaked certificates used from outside Amazon EC2 and outside the
authorized IP ranges (for example, from addresses outside your company) are
still denied access.
  "
  desc  'check', "
    Input:

    ```
    aws eks describe-cluster \\
     --region <region> \\
     --name <clustername>
    ```
    Output:

    ```
     ...
     \"endpointPublicAccess\": false,
     \"endpointPrivateAccess\": true,
     \"publicAccessCidrs\": [
     \"203.0.113.5/32\"
     ]
     ...
    ```
  "
  desc  'fix', "
    Complete the following steps using the AWS CLI version 1.18.10 or later.
You can check your current version with aws --version. To install or upgrade
the AWS CLI, see Installing the AWS CLI.

    Update your cluster API server endpoint access with the following AWS CLI
command. Substitute your cluster name and desired endpoint access values. If
you set endpointPublicAccess=true, then you can (optionally) enter single CIDR
block, or a comma-separated list of CIDR blocks for publicAccessCidrs. The
blocks cannot include reserved addresses. If you specify CIDR blocks, then the
public API server endpoint will only receive requests from the listed blocks.
There is a maximum number of CIDR blocks that you can specify. For more
information, see Amazon EKS Service Quotas. If you restrict access to your
public endpoint using CIDR blocks, it is recommended that you also enable
private endpoint access so that worker nodes and Fargate pods (if you use them)
can communicate with the cluster. Without the private endpoint enabled, your
public access endpoint CIDR sources must include the egress sources from your
VPC. For example, if you have a worker node in a private subnet that
communicates to the internet through a NAT Gateway, you will need to add the
outbound IP address of the NAT gateway as part of a whitelisted CIDR block on
your public endpoint. If you specify no CIDR blocks, then the public API server
endpoint receives requests from all (0.0.0.0/0) IP addresses.
    Note
    The following command enables private access and public access from a
single IP address for the API server endpoint. Replace 203.0.113.5/32 with a
single CIDR block, or a comma-separated list of CIDR blocks that you want to
restrict network access to.

    Example command:
    ```
    aws eks update-cluster-config \\
     --region region-code \\
     --name dev \\
     --resources-vpc-config \\
     endpointPublicAccess=true, \\
     publicAccessCidrs=\"203.0.113.5/32\",\\
     endpointPrivateAccess=true
    ```

    Output:

    ```
    {
     \"update\": {
     \"id\": \"e6f0905f-a5d4-4a2a-8c49-EXAMPLE00000\",
     \"status\": \"InProgress\",
     \"type\": \"EndpointAccessUpdate\",
     \"params\": [
     {
     \"type\": \"EndpointPublicAccess\",
     \"value\": \"true\"
     },
     {
     \"type\": \"EndpointPrivateAccess\",
     \"value\": \"true\"
     },
     {
     \"type\": \"publicAccessCidrs\",
     \"value\": \"[\\203.0.113.5/32\\\"]\"
     }
     ],
     \"createdAt\": 1576874258.137,
     \"errors\": []
     }
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
  tag nist: ['AC-3 (3)', 'Rev_4']
  tag cis_level: 1
  tag cis_controls: ['14.6', 'Rev_7']
  tag cis_rid: '5.4.1'

  region = input('cluster-region')
  name = input('cluster-name')

  expected_allowlist = input('allowlist_cidr_blocks')

  access_restrictions = json({command: "aws eks describe-cluster --region #{region} --name #{name} --query cluster.resourcesVpcConfig"})
  actual_allowlist = access_restrictions['publicAccessCidrs']


  describe "Private access should be enabled" do
    subject { access_restrictions }
    its('endpointPrivateAccess') { should be true }
  end

  describe.one do
    describe "Public access should be disabled" do
      subject { access_restrictions }
      its('endpointPublicAccess') { should be false }
    end
    describe "Public access should be restricted to an allowlist of CIDR blocks" do
      subject { allowlist }
      it { should exist }
    end
  end
  if actual_allowlist
    actual_allowlist.each do |cidr|
      describe "Cluster allowlist should match expected allowlist" do
        subject { cidr }
        it { should be_in expected_allowlist }
      end
    end
  end
end

