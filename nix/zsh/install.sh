#!/bin/bash
export versionGo=1.24.2
export versionZig=0.14.0

usedArch=$(uname -m)
case $usedArch in
	"amd64" | "x86_64")
		usedArch="amd64"
		;;
	"arm64" | "aarch64")
		usedArch="arm64"
		;;
	*)
		echo "Unknown architecture."
		exit 1
		;;
esac

if [ ! -e "/opt/go" ]; then
	echo "Installing Go..."
	curl -L "https://go.dev/dl/go${versionGo}.linux-${usedArch}.tar.gz" | tar -zxf - -C /opt
fi
if [ ! -e "/opt/zig" ]; then
	echo "Installing Zig..."
	realArch=$usedArch
	case $usedArch in
		"amd64")
			realArch="x86_64"
			;;
		"arm64")
			realArch="aarch64"
			;;
	esac
	curl -L "https://ziglang.org/download/${versionZig}/zig-linux-${realArch}-${versionZig}.tar.xz" | tar -Jxf - -C /opt
	mv /opt/zig-* /opt/zig
fi
mkdir -p ~/.local/bin
if [ ! -f ~/.local/bin/go ]; then
	ln -s /opt/go/bin/go ~/.local/bin
fi
if [ ! -f ~/.local/bin/gofmt ]; then
	ln -s /opt/go/bin/gofmt ~/.local/bin
fi
if [ ! -f ~/.local/bin/zig ]; then
	ln -s /opt/zig/zig ~/.local/bin
fi

dpkg --add-architecture amd64
dpkg --add-architecture arm64
apt-get update
apt install -y git >/dev/null 2>/dev/null
apt install -y --no-install-recommends libgl-dev:amd64 libx11-dev:amd64 libxrandr-dev:amd64 libxxf86vm-dev:amd64 libxi-dev:amd64 libxcursor-dev:amd64 libxinerama-dev:amd64 libxkbcommon-dev:amd64 >/dev/null 2>/dev/null
apt install -y --no-install-recommends libgl-dev:arm64 libx11-dev:arm64 libxrandr-dev:arm64 libxxf86vm-dev:arm64 libxi-dev:arm64 libxcursor-dev:arm64 libxinerama-dev:arm64 libxkbcommon-dev:arm64 >/dev/null 2>/dev/null
