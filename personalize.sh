#!/bin/bash

if [ -z "$1" ]; then
  echo "./personalize.sh <username> [repository_name] [image_name]"
  exit 1
fi

username=$1
repository_name=$2
image_name=$3

find . -type f -name '*.yaml' -exec sed -E -i '' s#https://github.com/[-_a-zA-Z0-9]+#https://github.com/${username}#g {} +
find . -type f -name '*.yaml' -exec sed -E -i '' s#ghcr.io/[-_a-zA-Z0-9]+#ghcr.io/${username}#g {} +

if [ ! -z "$repository_name" ]; then
  find . -type f -name '*.yaml' -exec sed -E -i '' "s#https://github.com/${username}/[-_a-zA-Z0-9]+#https://github.com/${username}/${repository_name}#g" {} +
fi

if [ ! -z "$image_name" ]; then
  find . -type f -name '*.yaml' -exec sed -E -i '' "s#ghcr.io/${username}/[-_a-zA-Z0-9]+#ghcr.io/${username}/${image_name}#g" {} +
fi
