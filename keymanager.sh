#!/bin/sh

set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:$ETCD_PORT

# Try to make initial configuration every 5 seconds until successful
until confd -onetime -node $ETCD -config-file /ssh.toml; do
  echo "[sshkey] waiting for confd to create initial sshkey configuration."
  sleep 5
done

# Put a continual polling `confd` process into the background to watch
# for changes every 10 seconds
confd -interval 10 -node $ETCD -config-file /ssh.toml &

tail -f /dev/null
