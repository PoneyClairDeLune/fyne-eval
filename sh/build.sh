#!/bin/bash
ls -1 "./go" | while IFS= read -r folder; do
	if [ -f "./go/${folder}/main.go" ]; then
		echob "Building \"${folder}\"..."
		go build -o "./build/${folder}" "./go/${folder}/main.go"
	fi
done
exit