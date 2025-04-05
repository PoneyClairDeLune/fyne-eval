#!/bin/bash
ls -1 "./go" | while IFS= read -r folder; do
	if [ -f "./go/${folder}/main.go" ]; then
		echob "Building \"${folder}\"..."
		fileName="./build/${folder}"
		if [ "${GOOS}" != "" ]; then
			fileName="${fileName}_${GOOS}"
		fi
		if [ "${GOARCH}" != "" ]; then
			fileName="${fileName}_${GOARCH}"
		fi
		if [ "${CLIB}" != "" ]; then
			fileName="${fileName}_${CLIB}"
		fi
		if [ "${GOOS}" == "windows" ]; then
			fileName="${fileName}.exe"
		fi
		go build -o "$fileName" "./go/${folder}/main.go"
	fi
done
exit
