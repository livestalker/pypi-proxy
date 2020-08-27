FROM python:3.8.5-buster
RUN pip install -q -U devpi-server devpi-web devpi-client
RUN devpi-init
COPY etc/devpi/devpi-server.yml /root/.config/devpi-server/devpi-server.yml
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80
CMD ["devpi-server"]
