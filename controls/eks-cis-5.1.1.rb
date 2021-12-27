control 'eks-cis-5.1.1' do
  title 'Ensure Image Vulnerability Scanning using Amazon ECR image
  scanning or a third party provider'
  desc  'Scan images being deployed to Amazon EKS for vulnerabilities.'
  desc  'rationale', "Vulnerabilities in software packages can be exploited by
hackers or malicious users to obtain unauthorized access to local cloud
resources. Amazon ECR and other third party products allow images to be scanned
for known vulnerabilities."
  desc  'check', "Please follow AWS ECS or your 3rd party image scanning
provider's guidelines for enabling Image Scanning."
  desc  'fix', "
    To utilize AWS ECR for Image scanning please follow the steps below:

    To create a repository configured for scan on push (AWS CLI)
    ```
    aws ecr create-repository --repository-name $REPO_NAME
--image-scanning-configuration scanOnPush=true --region $REGION_CODE
    ```

    To edit the settings of an existing repository (AWS CLI)
    ```
    aws ecr put-image-scanning-configuration --repository-name $REPO_NAME
--image-scanning-configuration scanOnPush=true --region $REGION_CODE
    ```

    Use the following steps to start a manual image scan using the AWS
Management Console.

    1. Open the Amazon ECR console at
https://console.aws.amazon.com/ecr/repositories.
    2. From the navigation bar, choose the Region to create your repository in.
    3. In the navigation pane, choose Repositories.
    4. On the Repositories page, choose the repository that contains the image
to scan.
    5. On the Images page, select the image to scan and then choose Scan.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: nil
  tag gid: nil
  tag rid: nil
  tag stig_id: nil
  tag fix_id: nil
  tag cci: nil
  tag nist: %w(RA-5 Rev_4)
  tag cis_level: 1
  tag cis_controls: %w(3 Rev_7)
  tag cis_rid: '5.1.1'

  describe 'Manual control' do
    skip 'Manual review is required to ensure images are scanned for vulnerabilities'
  end
end
