#!/usr/bin/env bash

# create-dockerfile script.

#######################################
# Prints a message to the command line with a timestamp.
# Arguments:
#   Message to print.
#######################################
msg(){
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $1" >&1
}

#######################################
# Prints an error message to the command line with a timestamp. If an error code
# is included, exit the program.
# Arguments:
#   Error message to print.
#   OPTIONAL: Error code.
#######################################
err() {
  echo -e "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $1" >&2

  if [[ -z "${2-}" ]]; then
    exit "${2}"
  fi
}

#######################################
# Gets the passed arguments to the script.
# Globals:
#   Any set.
#######################################
parse_params(){
  name=''
  image=''

  while :; do
    case "${1-}" in
      -h | --help) usage ;;

      -v | --verbose) set -x ;;

      -?*) close "Unknown option: $1" ;;

      *) break ;;
    esac

    shift
  done

  args=("$@")

  [[ ${#args[@]} -eq 0 ]] && close "Missing script arguments" 1
  [[ -z "${args[0]-}" ]] && close "Missing required parameter: image_name" 1 \
  || name=${args[0]}
  [[ -z "${args[1]-}" ]] && close "Missing required parameter: base_image" 1 \
  || image=${args[1]}
}

#######################################
# Prints the usage of the function.
#######################################
usage(){
  cat <<- EOF
  Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] image_name base_image

  Creates a Dockerfile directory for creating a custom image. It includes a
  default Dockerfile with a base image, and a build and a run script.

  Available options:

  -h, --help      Print this help and exit
  -v, --verbose   Print script debug info
EOF
  exit
}

# Script setup.
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
parse_params "$@"

# Main script logic.
mkdir "$name"
cat <<-EOF > "$name"/Dockerfile
FROM $image
USER root
EOF

cat <<-EOF > "$name"/build.sh
#!/bin/bash
#
# Builds the $name image.

docker build -t mlbarker/$name:1.0
EOF

cat <<-EOF > "$name"/run.sh
#!/bin/bash
#
# Runs the $name image in a Docker container.

docker run mlbarker/$name:1.0
EOF

cat <<-EOF > "$name"/docker-compose.yml
version: "3.8"

services:
EOF
exit
