
traditional way before infrastructure as code:
- manual process
- error-prone
- time-consuming
- difficult to scale
- difficult to maintain
- difficult to reproduce

infrastructure as code  is a way to automate the process of managing and provisioning infrastructure.

terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

terraform features:
- Infrastructure as Code 
- Execution Plans
- Resource Graph
- Change Automation

**infra as code**: terraform configuration files describe to the terraform engine how to build the infrastructure.
**execution plans**: terraform generates an execution plan describing what it will do to reach the desired state.
**resource graph**: terraform builds a graph of all your resources, and parallelizes the creation and destruction of non-dependent resources.
**change automation**: complex changesets can be applied to your infrastructure with minimal human interaction