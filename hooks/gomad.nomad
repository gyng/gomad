job "gomad" {
    datacenters = ["ap-southeast-1a", "ap-southeast-1b"]

    group "webhook" {
        count = 1

        task "server" {
            driver = "docker"

            env {
                NOMAD_ADDR = "{{ key \"gomad/NOMAD_ADDR\" }}"
            }

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
            }

            // template {
            //     data = "{{ key \"gomad/hooks/hooks.json\" }}"
            //     destination = "local/hooks/hooks.json"
            // }

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
                    "traefik.frontend.rule=Host:{{ key \"gomad/host\" }}"
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