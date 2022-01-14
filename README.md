# appd-db-agent
The Dockerfile pulls in a local appd-db-agent installer tarball, so that must be downloaded. Download it from the correct controller so the API tokens are already baked into the agent tarall. The tarball name is usually something like:
db-agent-21.12.4.2589.zip


## Usage

### Download the controller-specific db-agent zip
Download the appdynamics db-agent from the controller rather than the public download site. This  method configures the agent zip with the settings anc credentials to connect to your personal appd backend (controller). NOTE: you may have multiple controllers so, you may need to download the zip for each one and create a docker image for each.

NOTE: When you download themfile, I'd rename it right away to prepend the controller name to the file so you know which is whihch.

example: my-controller-db-agent-21.12.4.2589.zip

the gitignore will match this name and ignore it

### Move/rename the zip
The Dockefile looks for the file db-agent.zip, so move the installer zip into this project at appd-db-agent/db-agent.zip


### build the docker image

Specify your controller name
```shell
make CONTROLLER-my-controller build

```

### Push the image to AWS ECR
This assumes you ahve the registry named 'appd-db-agent' in your AWS account and region



install git
clone this project

download the installer that have the creds in it for the conntroller
build the image locally and run it wiht the agent name environment variable passed in

