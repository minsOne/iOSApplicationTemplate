.PHONY: carthage

carthage:
	./carthage.sh update --platform iOS --use-xcframeworks --no-use-binaries
