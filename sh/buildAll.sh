#!/bin/bash
if [ ! -f "$(which fyne-cross)" ]; then
	echo "Cross-compiler for Fyne is not present."
	exit 1
fi
cat ./targets.conf | while IFS= read -r target; do
	export GOOS=$(printf $target | cut -d'_' -f1)
	export GOARCH=$(printf $target | cut -d'_' -f2)
	echob "Currently building on \"${GOARCH}\" for \"${GOOS}\"."
	ls -1 ./go | while IFS= read -r folder; do
		if [ -f "./go/${folder}/main.go" ]; then
			echob "Cross-compiling \"${folder}\"..."
			fyne-cross "${GOOS}" -arch=${GOARCH} -output "./build/${folder}_${target}" "./go/${folder}/main.go"
		fi
	done
	echob "Cross compilation finished."
done
exit