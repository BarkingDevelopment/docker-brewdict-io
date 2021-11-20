#!/bin/bash
#
# Builds the ssh-agent image.

docker build -t mlbarker/ssh-agent:1.2 -t mlbarker/ssh-agent:latest .
