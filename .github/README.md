## Overview

This Ansible playbook deploys a container cluster on a group of servers distributed over several data centers. In this particular setup, the assumption on infrastructure is:

| **NODE**       | **CLUSTER ROLE**           |
|----------------|----------------------------|
| Home server    | Manager / Worker           |
| VPS            | Manager / Worker / Ingress |
| AMD Compute #1 | Ingress                    |
| AMD Compute #2 | Ingress                    |
| ARM Ampere #1  | Manager / Worker           |
| ARM Ampere #2  | Worker                     |

...where the Compute and Ampere nodes exist on the [OCI Free Tier](https://www.oracle.com/cloud/free/#always-free).

### Features

+ **Orchestration**: Services are managed by [Docker Swarm mode](https://docs.docker.com/engine/swarm/) (default) or [Nomad](https://docs.docker.com/engine/swarm/) (prototype)
+ **Encryption**: Cluster nodes communicate exclusively over a private [Wireguard](https://www.wireguard.com/) mesh network
+ **Need-to-know**: Necessary ports (`ssh`,`https`, etc.) are open on ingress nodes only; requests are reverse-proxied to containerized services on the common overlay network
+ **Distributed storage**: [GlusterFS](https://www.gluster.org/) or [Syncthing](https://syncthing.net/) (default)
+ **Cloud storage**: Use [rclone](https://rclone.org/) as a [Docker volume plugin](https://rclone.org/docker/) to mount any cloud storage as a storage backend for services
+ **Security**: [CrowdSec](https://www.crowdsec.net/) (default) or [Fail2ban](https://www.fail2ban.org/); reasonably hardened `ssh` config; unattended upgrades

### TODO

+ Include example Swarm stacks:
	- Reverse proxy
	- L4 proxy
	- Nextcloud
	- Mailserver
	- DNS over TLS
	- ...and so on

---

## CAUTION

This is a personalized setup, not a cookie-cutter playbook, so any use outside of the intended environment requires the appropriate adjustments to roles and variables.
