# eks-cis-baseline

InSpec profile to validate the secure configuration of AWS EKS, against [CIS](https://www.cisecurity.org/cis-benchmarks/)'s CIS Amazon Elastic Kubernetes Service (EKS) Benchmark version 1.0.1.

## Getting Started

It is intended and recommended that InSpec run this profile from a **"runner"** host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target remotely over **winrm**.

**For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.**

Latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

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
