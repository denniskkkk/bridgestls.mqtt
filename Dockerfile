FROM ubuntu:focal as build

RUN groupadd -r mosquitto && useradd -r -g mosquitto mosquitto; \
	apt-get update; \
	apt-get install -y vim curl wget iputils-ping mosquitto mosquitto-clients mosquitto-dev net-tools
	
COPY --chown=root:root entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 1883
EXPOSE 8883
EXPOSE 9001
CMD /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
	
	
