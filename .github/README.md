## Overview

This Ansible playbook deploys a container cluster on a group of servers distributed over several data centers. In this particular setup, the assumption on infrastructure is:

| **NODE** 	| **ROLE**         	| **DATACENTER** 	|
|----------	|------------------	|----------------	|
| home     	| Manager / Worker 	| 1              	|
| raspi    	| Manager          	| 1              	|
| vps      	| Manager / Worker 	| 2              	|
| green    	| Worker           	| 3              	|
| hippo    	| Worker           	| 4              	|

### Features

+ **Orchestration**: Services are managed by [Docker Swarm mode](https://docs.docker.com/engine/swarm/) (default) or [Nomad](https://docs.docker.com/engine/swarm/) (prototype)
+ **Encryption**: Cluster nodes communicate exclusively over a private [Wireguard](https://www.wireguard.com/) mesh network
+ **Security**: [CrowdSec](https://www.crowdsec.net/) (default) or [Fail2ban](https://www.fail2ban.org/); reasonably hardened `ssh` config; unattended upgrades
+ **Need-to-know**: Service ports (`https`, `imap`, `DoT`, etc.) are open on ingress nodes only; all requests get reverse-proxied to containerized services on a common overlay network
+ **Cloud storage**: [Rclone](https://rclone.org/) as a [Docker volume plugin](https://rclone.org/docker/) for mounting any cloud storage as a storage backend for services
+ **Distributed storage**: [GlusterFS](https://www.gluster.org/) or [Syncthing](https://syncthing.net/) (default)

---

## CAUTION

This is a personalized setup, not a cookie-cutter playbook, so any use outside of the intended environment requires the appropriate adjustments to roles and variables.
