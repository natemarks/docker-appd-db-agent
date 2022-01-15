# appd-db-agent
This project makes it easier to create a docker image from an appd-db-agent zip file. When correctly downloaded from a specific controller console, the zip file contains credentials, so it can't be included in the project. it must be downloaded separately. It can be run from any host with the AWS credentials required to upload ECR images.

Once all of the pre-requisites are satisfied, I can build my docker image locally with the command below. 

```shell
# build the image: my-controller-appd-db-agent:21.12.4.2589
make CONTROLLER=my-controller AGENT_VERSION=21.12.4.2589 build
```

Assuming I have an AWS ECR registry named 'my-controller-appd-db-agent', this would push the local image to the ECR registry
```shell
make CONTROLLER=my-controller AGENT_VERSION=21.12.4.2589 upload_to_ecr

```
## Prepre your ECR registries
for each  Appd-controller you have, create the ECR registries in the desired AWS account

### Download the controller-specific db-agent zip
Download the appdynamics db-agent from the controller rather than the public download site. This  method configures the agent zip with the settings and credentials to connect to your personal appd backend (controller). Often, people have different controllers for different environments (production, pre-prod, etc.).  YOu'll need to download the zip for each one and create a docker image for each.

NOTE: When you download the file, I'd rename it right away to prepend the controller name to the file so you know which is whihch.

example: my-controller-db-agent-21.12.4.2589.zip

the gitignore will match this name and ignore it

### Move/rename the zip
The Dockefile looks for the file db-agent.zip, so move the installer zip into this project at appd-db-agent/db-agent.zip


### build the docker image

Specify your controller name
```shell
make CONTROLLER-my-controller AGENT_VERSION=21.12.4.2589 build
```

### Push the image to AWS ECR
```shell
 make CONTROLLER=my-controller AGENT_VERSION=21.12.4.2589 upload_to_ecr
```
This assumes you have an ECR registry named for each controller in your account and region
ECR registry name examples:
prod-appd-db-agent
non-prod-appd-db-agent
