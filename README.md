# eks-cis-cluster-baseline

InSpec profile to validate the secure configuration of AWS EKS, against [CIS](https://www.cisecurity.org/cis-benchmarks/)'s CIS Amazon Elastic Kubernetes Service (EKS) Benchmark version 1.0.1 (Cluster requirements).

The baseline includes tests that must be executed against the Kubernetes API and tests that must be executed against the underlying nodes over SSH. This profile handles only the cluster tests, and is intended to be run alongside the [EKS CIS Node Baseline profile](https://github.com/mitre/eks-cis-node-baseline).

## Getting Started

This profile should be executed from a runner host with network access to the EKS cluster under test. The runner host must have InSpec installed.

**For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.**

Latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

## Dependencies

This profile is executed against an AWS EKS cluster via the Kubernetes API and the AWS CLI. The profile assumes that the runner is authenticated as an AWS role permitted to run the `kubectl` utility against the cluster and run queries using the `aws eks` CLI command.

### Kubernetes API

The profile makes use of the `kubectl` utility to access the Kubernetes API. The runner host must have `kubectl` installed -- see the [Kubernetes documentation for tools](https://kubernetes.io/docs/tasks/tools/) for details.

A host's connection to the Kubernetes API is established using credentials recorded in the `kubeconfig` file. For the profile to use the Kubernetes API, the runner host must either have a valid `kubeconfig` file either in the default location ($HOME/.kube/config) or have designated a file as the `kubeconfig` file using the `$KUBECONFIG` environment variable. See the [Kubernetes documentation for kubeconfig](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/) for details.

You can test if the runner host has access to the Kubernetes API by running `kubectl` from the command line:

```
kubectl get nodes
```

If the command returns a list of information on the EC2 nodes that comprise the cluster, then `kubectl` is able to support the profile.

### AWS CLI

Some controls in the profile require the use of the AWS CLI to investigate the EKS cluster. Ensure the runner host has the AWS CLI installed as per [Amazon's instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

The runner host must also have assumed a role with sufficient permissions to access the AWS components of the EKS cluster. If running AWS commands results in a permission error, work with your cloud administrator to ensure your role has the correct IAM privileges to access the cluster's components.

To ensure the AWS CLI is installed and configured correctly, use it to print information on the target cluster:

```
aws eks describe-cluster --name <cluster name> --region <cluster region>
```

## Tailoring to Your Environment

The following inputs may be configured in an inputs ".yml" file for the profile to run correctly for your specific environment. More information about InSpec inputs can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

```yaml
# Used by the AWS CLI controls. Give the name of the cluster under test
# as a string, ex. "my-test-cluster"
cluster-name:

# Used by the AWS CLI controls. Give the region of the cluster under test
# as a string, ex. "us-east-1"
cluster-region:

# Used by 4.1.1. Give an array of roles which are permitted to hold the
# cluster-admin role.
# If not defined, default is: ["system:admin", "system:masters"]
allowed_cluster_admin_principals:

# Optional -- leave blank if no outside access should be allowed
# IPs from within this array of CIDR blocks should be the only ones allowed to
# access the cluster via k8s API from outside the VPC
# Can be configured via AWS console
# Ex. ["0.0.0.0/0"]
allowlist_cidr_blocks:
```

## Running the Profile

Executing the profile by downloading it to the runner:

```
git clone https://github.com/mitre/eks-cis-cluster-baseline.git
cd eks-cis-cluster-baseline
inspec exec . --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter cli json:node1results.json
```

Executing the profile by executing it from this GitHub repository:

```
inspec exec https://github.com/mitre/eks-cis-cluster-baseline/archive/main.tar.gz --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter cli json:cluster-results.json
```

## Running This Baseline from a local Archive copy

If your runner is not always expected to have direct access to GitHub, use the following steps to create an archive bundle of this profile and all of its dependent tests:

(Git is required to clone the InSpec profile using the instructions below. Git can be downloaded from the [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) site.)

```
mkdir profiles
cd profiles
git clone https://github.com/mitre/eks-cis-cluster-baseline.git
inspec archive eks-cis-cluster-baseline
sudo inspec exec <archive name> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter cli json:cluster-results.json
```

For every successive run, follow these steps to always have the latest version of this baseline and dependent profiles:

```
cd eks-cis-cluster-baseline
git pull
cd ..
inspec archive eks-cis-cluster-baseline --overwrite
sudo inspec exec <archive name> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter cli json:cluster-results.json
```

## Using Heimdall for Viewing the JSON Results

![Heimdall Lite 2.0 Demo GIF](https://github.com/mitre/heimdall2/blob/master/apps/frontend/public/heimdall-lite-2.0-demo-5fps.gif)

The JSON results output file can be loaded into **[heimdall-lite](https://heimdall-lite.mitre.org/)** for a user-interactive, graphical view of the InSpec results.

The JSON InSpec results file may also be loaded into a **[full heimdall server](https://github.com/mitre/heimdall)**, allowing for additional functionality such as to store and compare multiple profile runs.

## Authors

- Will Dower - [wdower](https://github.com/wdower)

## Special Thanks

- Rony Xavier - [rx294](https://github.com/rx294)

## Contributing and Getting Help

To report a bug or feature request, please open an [issue](https://github.com/mitre/eks-cis-baseline/issues/new).

### NOTICE

© 2018-2021 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA 22102-7539, (703) 983-6000.

## NOTICE

CIS Benchmarks are published by the Center for Internet Security (CIS), see: https://www.cisecurity.org/cis-benchmarks/.
