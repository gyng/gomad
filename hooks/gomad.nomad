job "gomad" {
    datacenters = ["ap-southeast-1a", "ap-southeast-1b"]

    group "webhook" {
        count = 1

        task "server" {
            driver = "docker"

            config {
                image = "gyng/gomad"
                command = "webhook"
                args = [
                    "-hooks",
                    "/hooks/hooks.json",
                    "-verbose"
                ]

                port_map = {
                    http = 9000
                }

                volumes = [
                    "local/hooks/hooks.json:/hooks/hooks.json"
                ]

                dns_servers = ["169.254.1.1"]
            }

            // TODO: Extract hooks.json from KV, check in and use templates to
            // interpolate sensitive things (eg. tokens)
            template {
                data = "{{ key \"gomad/hooks.json\" }}"
                destination = "local/hooks/hooks.json"
            }

            service {
                name = "${JOB}-server"
                port = "http"

                check {
                    name     = "gomad-web-check"
                    type     = "tcp"
                    interval = "60s"
                    timeout  = "5s"
                }

                tags = [
                    "traefik.enable=true",
                    "traefik.frontend.rule=Host:gomad.nomad.gahmen.tech"
                ]
            }

            resources {
                memory = 300

                network {
                    port "http" {}
                }
            }
        }
    }
}