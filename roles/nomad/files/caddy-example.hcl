job "caddy" {
  datacenters = ["dc1"]
  type = "service"

  constraint {
    attribute = "${meta.ingress}"
    value = "true"
  }

  group "reverse_proxy" {
    count = 1

    network {
      port "http" {
        static = 80
        to     = 80
        host_network = "host"
      }

      port "https" {
        static = 443
        to     = 443
        host_network = "host"
      }
    }

    task "caddy" {
      driver = "docker"

      config {
        image = "ghcr.io/cycneuramus/caddy:latest"
        ports = ["http", "https"]

        mount {
          type = "volume"
          source = "test"
          target = "/test"
          readonly = true
          volume_options {
            driver_config {
              name = "rclone"
              options {
                remote = "nextcloud:test"
                allow_other = "true"
                vfs_cache_mode = "full"
                vfs_cache_max_size = "1G"
                poll_interval = "0"
                uid = "1000"
                gid = "1000"
              }
            }
          }
        }

        mount {
          type = "bind"
          source = "config"
          target = "/etc/caddy"
        }

        mount {
          type = "bind"
          source = "data"
          target = "/data/caddy"
          readonly = false
        }
      }
    }
  }
}
