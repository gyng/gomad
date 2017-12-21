#!/bin/sh
echo Deploying gomad @ $NOMAD_ADDR

nomad run hooks/gomad.nomad
