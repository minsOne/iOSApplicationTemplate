.PHONY: carthage

carthage:
	./carthage.sh checkout
	rm -rf Carthage/Checkouts/PinLayout/TestProjects
	./carthage.sh build --platform iOS --use-xcframeworks
