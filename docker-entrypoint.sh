#!/usr/bin/env bash
set -Eeo pipefail

docker_setup_env() {
	declare -g DEVPY_ALREADY_INIT

	if [ -f "/root/.devpy.init" ]; then
		DEVPY_ALREADY_INIT='true'
	fi
}

_main() {
  docker_setup_env
  if [ -z "$DEVPY_ALREADY_INIT" ]; then
    devpi-server 1>/dev/null &
    DEVPI_PID=$!
    sleep 5
    devpi use http://localhost:80
    devpi login root --password ''
    devpi index root/pypi mirror_url="$MIRROR_URL" mirror_web_url_fmt="$MIRROR_FMT" title="$MIRROR_TITLE"
    kill "$DEVPI_PID"
    touch /root/.devpy.init
  fi

  exec "$@"
}

_main "$@"