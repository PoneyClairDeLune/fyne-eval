#!/bin/bash
function getToolchain {
	cLibTarget="gnu"
	if [ "$3" != "" ]; then
		cLibTarget="$3"
	fi
	if [ "$3" == "" ] && [ "$1" == "linux" ]; then
		case $2 in
			"amd64")
				printf "x86_64-linux-gnu-gcc"
				;;
			"arm64")
				printf "aarch64-linux-gnu-gcc"
				;;
			"riscv64")
				printf "riscv64-linux-gnu-gcc"
				;;
		esac
	else
		case $2 in
			"amd64")
				printf "zig cc -target x86_64-${1}-${cLibTarget}"
				;;
			"arm64")
				printf "zig cc -target aarch64-${1}-${cLibTarget}"
				;;
			"riscv64")
				printf "zig cc -target riscv64-${1}-${cLibTarget}"
				;;
		esac
	fi
}

rawArch=$(uname -m)
rootArch=$rawArch
case $rawArch in
	"x86_64" | "amd64")
		rootArch="amd64"
		;;
	"arm64" | "armv8l" | "aarch64")
		rootArch="arm64"
		;;
esac
cat ./targets.conf | while IFS= read -r target; do
	export GOOS=$(printf $target | cut -d'_' -f1)
	export GOARCH=$(printf $target | cut -d'_' -f2)
	export CLIB=$(printf $target | cut -d'_' -f3)
	export CC="$(getToolchain $GOOS $GOARCH $CLIB)"
	echob "Currently building on \"${GOARCH}\" for \"${GOOS}\"."
	if [ "${GOOS}" == "linux" ] && [ "${GOARCH}" == "${rootArch}" ]; then
		shx build
	else
		CGO_ENABLED=1 shx build
	fi
	echob "Cross compilation finished."
done
exit
