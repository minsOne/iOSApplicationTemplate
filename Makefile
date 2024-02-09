.PHONY: carthage

carthage:
	./carthage.sh outdated
	./carthage.sh checkout
	rm -rf Carthage/Checkouts/FLEX/Example
	rm -rf Carthage/Checkouts/PinLayout/TestProjects
	./carthage.sh build --platform iOS --use-xcframeworks --no-use-binaries
