#!/bin/sh
echo Redeploying gomad!

nomad run hooks/gomad.nomad
