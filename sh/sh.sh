#!/bin/bash
# shx Standard Utility
useNix=${1:-env}
ociRun=
gpgSrc=
if [ -d "$USER_DIR/.gnupg" ]; then
	gpgSrc="$gpgSrc -v $USER_DIR/.gnupg:/root/.shadowSrc/.gnupg:ro"
fi
if [ -f "$USER_DIR/.gitconfig" ]; then
	gpgSrc="$gpgSrc -v $USER_DIR/.gitconfig:/root/.shadowSrc/.gitconfig:ro"
fi
if [ -e "$(which podman)" ]; then
	ociRun=podman
elif [ -e "$(which docker)" ]; then
	ociRun=docker
else
	echo "OCI provider is not available."
fi
if [ "$ociRun" != "" ]; then
	if [ ! -f "nix/zsh/.docker_name" ]; then
		dd if=/dev/random bs=3 count=4 | basenc --base64url > nix/zsh/.docker_name
	fi
	ociName="$(cat nix/zsh/.docker_name)"
	echo "Starting container..."
	mkdir -p "./nix/opt"
	$ociRun run -it -d --name "$ociName" -v "$SOURCE_DIR":/data $gpgSrc -v "$SOURCE_DIR/nix/opt":"/opt" docker.io/ltgc/gel:slimdeb sleep infinity 2>/dev/null
	$ociRun start "$ociName" 2>/dev/null
	$ociRun exec -it "$ociName" bash /data/nix/zsh/boot.sh "$useNix"
	echo "Quitting container..."
fi
exit
