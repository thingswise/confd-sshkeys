Reads entries from etcd:/sshkeys and writes them to /ssh/authorized_keys.
So if /ssh is mounted to $USER/.ssh, it will get the list of authorized 
pub keys. The default owner is "core".
