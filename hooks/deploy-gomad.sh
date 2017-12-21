#!/bin/sh
# echo Deploying gomad @ $NOMAD_ADDR

nomad run --address http://nomad.service.consul:4646 hooks/gomad.nomad
