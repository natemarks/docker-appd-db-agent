# appd-db-agent
The Dockerfile pulls in a local appd-db-agent installer tarball, so that must be downloaded. Download it from the correct controller so the API tokens are already baked into the agent tarall. The tarball name is usually something like:
db-agent-21.12.4.2589.zip


## Usage

install git
clone this project

download the installer that have the creds in it for the conntroller
build the image locally and run it wiht the agent name environment variable passed in

