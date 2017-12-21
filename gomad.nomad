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
                    "-hooks"
                    "/hooks/hooks.json",
                    "-verbose"
                ]

                port_map = {
                    http = 9000
                }

                // volumes = [
                //     "local/hooks:/hooks"
                // ]
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
                    "traefik.frontend.rule=Host:a.b.c.d"
                ]
            }

            resources {
                memory = 300
            }
        }
    }
}