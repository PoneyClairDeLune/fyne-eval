#!/bin/bash
cat ./targets.conf | while IFS= read -r target; do
	export GOOS=$(printf $target | cut -d'_' -f1)
	export GOARCH=$(printf $target | cut -d'_' -f2)
	echob "Currently building on \"${GOARCH}\" for \"${GOOS}\"."
	shx build "_${target}"
	echob "Cross compilation finished."
done
exit