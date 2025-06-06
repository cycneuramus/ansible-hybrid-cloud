> [!NOTE]
> The "hybrid-cloud" aspect of this playbook has been deprecated and moved to the [cloud](https://github.com/cycneuramus/ansible-hybrid-cloud/tree/cloud) branch.

______________________________________________________________________

## Overview

This Ansible playbook provisions a group of bare-metal Debian Stable servers and deploys a container orchestration cluster. In this particular setup, the assumption on infrastructure is:

| **NODE** | **ROLE** | **DATACENTER** |
|---------- |------------------ |---------------- |
| apex | Manager / Worker | 1 |
| ambi | Manager / Worker | 1 |
| horreum | Manager / Worker | 1 |

### Features

- **Orchestration**: The cluster is orchestrated by [Nomad](https://www.nomadproject.io) (default) or [Docker Swarm mode](https://docs.docker.com/engine/swarm/)
- **Encryption**: Cluster nodes communicate exclusively over a private [Wireguard](https://www.wireguard.com/) mesh network
- **Security**: [CrowdSec](https://www.crowdsec.net/) (default) or [Fail2ban](https://www.fail2ban.org/); reasonably hardened `ssh` config; unattended upgrades
- **Need-to-know**: Service ports (`HTTPS`, `IMAP`, `DoT`, etc.) are open on ingress nodes only; all requests get reverse-proxied to services over the encrypted mesh network
- **Distributed storage**: [JuiceFS](https://juicefs.com) (default – bring your own [backend](https://juicefs.com/docs/community/reference/how_to_set_up_object_storage/#supported-object-storage)), [GlusterFS](https://www.gluster.org/) or [Syncthing](https://syncthing.net/)
- **Cloud storage**: [Rclone](https://rclone.org/) with systemd-managed [FUSE mounts](https://rclone.org/commands/rclone_mount) (default) or as a [Docker volume plugin](https://rclone.org/docker/) for using almost any cloud storage as a backend for services

> [!CAUTION]
> This is a personalized setup, not a cookie-cutter playbook, so any use outside of the intended environment requires the appropriate adjustments to roles and variables.

______________________________________________________________________

## Usage

### Install dependencies

```sh
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
venv/bin/ansible-galaxy collection install -r requirements.yml
```

### Provision and deploy

```sh
ansible-playbook -i inventory.yml main.yml
```

### Upgrade

```sh
ansible-playbook -i inventory.yml upgrade.yml
```

> [!NOTE]
> The upgrade playbook assumes:
>
> - Nomad is the orchestrator
> - [`nmgr`](https://github.com/cycneuramus/nmgr) is installed server-side
