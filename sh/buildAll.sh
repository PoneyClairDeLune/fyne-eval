#!/bin/bash
function getToolchain {
	case $1 in
		"linux")
			case $2 in
				"amd64")
					if [ -f "$(which x86_64-linux-gnu-gcc)" ]; then
						printf "x86_64-linux-gnu-gcc"
					else
						printf "gcc"
					fi
					;;
				"arm64")
					if [ -f "$(which aarch64-linux-gnu-gcc)" ]; then
						printf "aarch64-linux-gnu-gcc"
					else
						printf "gcc"
					fi
					;;
			esac
			;;
		"windows")
			if [ -f "$(which x86_64-w64-mingw32-gcc)" ]; then
				printf "x86_64-w64-mingw32-gcc"
			else
				printf "x86_64-w64-mingw64-gcc"
			fi
			;;
	esac
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
	export CC="$(getToolchain $GOOS $GOARCH)"
	echob "Currently building on \"${GOARCH}\" for \"${GOOS}\"."
	if [ "${GOOS}" == "linux" ] && [ "${GOARCH}" == "${rootArch}" ]; then
		shx build
	else
		CGO_ENABLED=1 shx build
	fi
	echob "Cross compilation finished."
done
exit
