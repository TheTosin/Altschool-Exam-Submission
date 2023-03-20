# **Altschool-Exam-Submission**
This repo contains all files and codes for AltSchool of Cloud Engineering 3rd Semester Exam Submission

**Required Tools**:
Terraform, Docker and dockerhub, Kubernetes, Github, AWS CLI and Account, Prometheus, Domain (namecheap),
and Grafana.

**The files consist of both terraform and the userprofile files for the deployment**.
The aim of the Project is to deploy two applications: userprofile and socksshop with Kubernetes using an Iaac tool (AWS). 

The Terraform folder consists of Infrastructure, Deployment and monitoring files.

**The infrastructure folder** contains the terraform files for deploying the required infrastructure to AWS. It includes the network components like VPC, IGW, NAT-GW, Elastic IPs, Route tables and routes, subnets and security group. It also includes configurations for IAM roles, CloudWatch Log group, EKS node group and EKS cluster.

**The deployment folder** contains the scripts used for deploying the two applications to the AWS infrastructure. Terraform Kubernetes manifest, deployment and service resources were used to deploy the portfolio and socks shop apps. It also contains configuration for the subdomains, userprofile.adeshiletosin.live and socks.adeshiletosin.live.

**The monitoring folder** contains the scripts used to deploy prometheus and grafana to the cluster used for observing and monnitoring the uptime and performance of both applications.

**The userprofile** folder consists of dockercompose.yaml file, dockerfile and the app folder.
