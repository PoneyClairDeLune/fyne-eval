#!/bin/bash
bash /data/nix/zsh/install.sh
echo "Started. Container \"$(cat /data/nix/zsh/.docker_name)\" can be removed when no longer needed."
export PATH=~/.local/bin:$PATH
zsh
printf ""
exit
