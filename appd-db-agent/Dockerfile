
FROM adoptopenjdk/openjdk14:jdk-14.0.2_12-debian

# add credentials on build
ENV APPD_AGENT_NAME 'OVERRIDE_DECRYPTION_KEY'

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y unzip

COPY db-agent.zip db-agent.zip
RUN mkdir -p /opt/appd-dbagent
RUN unzip /db-agent.zip -d /opt/appd-dbagent


ENTRYPOINT ["/opt/appd-dbagent/start-dbagent -Ddbagent.name=\"${DB_AGENT_NAME:-north-west-blue}\""]
