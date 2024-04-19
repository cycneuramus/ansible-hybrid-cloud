## Overview

This Ansible playbook deploys a container orchestration cluster on a group of servers distributed over several data centers. In this particular setup, the assumption on infrastructure is:

| **NODE** 	| **ROLE**         	| **DATACENTER** 	|
|----------	|------------------	|----------------	|
| apex     	| Manager / Worker 	| 1              	|
| horreum   | Worker			      | 1              	|
| arca      | Manager / Worker 	| 2              	|
| arm    	  | Manger / Worker   | 3              	|
| green    	| Worker            | 4              	|

### Features

+ **Orchestration**: The cluster is orchestrated by [Nomad](https://www.nomadproject.io) (default) or [Docker Swarm mode](https://docs.docker.com/engine/swarm/)
+ **Encryption**: Cluster nodes communicate exclusively over a private [Wireguard](https://www.wireguard.com/) mesh network
+ **Security**: [CrowdSec](https://www.crowdsec.net/) (default) or [Fail2ban](https://www.fail2ban.org/); reasonably hardened `ssh` config; unattended upgrades
+ **Need-to-know**: Service ports (`HTTPS`, `IMAP`, `DoT`, etc.) are open on ingress nodes only; all requests get reverse-proxied to services over the encrypted mesh network
+ **Cloud storage**: [Rclone](https://rclone.org/) as a [Docker volume plugin](https://rclone.org/docker/) for mounting almost any cloud storage as a storage backend for services
+ **Distributed storage**: [GlusterFS](https://www.gluster.org/) or [Syncthing](https://syncthing.net/) (default)

---

## CAUTION

This is a personalized setup, not a cookie-cutter playbook, so any use outside of the intended environment requires the appropriate adjustments to roles and variables.
