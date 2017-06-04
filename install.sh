#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  cp ./dotnet.sh /usr/local/etc/bash_completion.d/dotnet
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  cp ./dotnet.sh /etc/bash_completion.d/dotnet
fi