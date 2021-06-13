RxBlocking1='Tuist/Dependencies/Carthage/RxBlocking.xcframework/ios-arm64_armv7/RxBlocking.framework/RxBlocking'
RxBlocking2='Tuist/Dependencies/Carthage/RxBlocking.xcframework/ios-arm64_i386_x86_64-simulator/RxBlocking.framework/RxBlocking'
RxTest1='Tuist/Dependencies/Carthage/RxTest.xcframework/ios-arm64_armv7/RxTest.framework/RxTest'
RxTest2='Tuist/Dependencies/Carthage/RxTest.xcframework/ios-arm64_i386_x86_64-simulator/RxTest.framework/RxTest'
RxNimbleRxBlocking1='Tuist/Dependencies/Carthage/RxNimbleRxBlocking.xcframework/ios-arm64_armv7/RxNimbleRxBlocking.framework/RxNimbleRxBlocking'
RxNimbleRxBlocking2='Tuist/Dependencies/Carthage/RxNimbleRxBlocking.xcframework/ios-arm64_i386_x86_64-simulator/RxNimbleRxBlocking.framework/RxNimbleRxBlocking'
RxNimbleRxTest1='Tuist/Dependencies/Carthage/RxNimbleRxTest.xcframework/ios-arm64_armv7/RxNimbleRxTest.framework/RxNimbleRxTest'
RxNimbleRxTest2='Tuist/Dependencies/Carthage/RxNimbleRxTest.xcframework/ios-arm64_i386_x86_64-simulator/RxNimbleRxTest.framework/RxNimbleRxTest'


install_name_tool -change @rpath/RxSwift.framework/RxSwift @rpath/ThirdPartyLibraryManager.framework/ThirdPartyLibraryManager $RxBlocking1
install_name_tool -change @rpath/RxSwift.framework/RxSwift @rpath/ThirdPartyLibraryManager.framework/ThirdPartyLibraryManager $RxBlocking2
install_name_tool -change @rpath/RxSwift.framework/RxSwift @rpath/ThirdPartyLibraryManager.framework/ThirdPartyLibraryManager $RxTest1
install_name_tool -change @rpath/RxSwift.framework/RxSwift @rpath/ThirdPartyLibraryManager.framework/ThirdPartyLibraryManager $RxTest2
install_name_tool -change @rpath/RxSwift.framework/RxSwift @rpath/ThirdPartyLibraryManager.framework/ThirdPartyLibraryManager $RxNimbleRxBlocking1
install_name_tool -change @rpath/RxSwift.framework/RxSwift @rpath/ThirdPartyLibraryManager.framework/ThirdPartyLibraryManager $RxNimbleRxBlocking2
install_name_tool -change @rpath/RxSwift.framework/RxSwift @rpath/ThirdPartyLibraryManager.framework/ThirdPartyLibraryManager $RxNimbleRxTest1
install_name_tool -change @rpath/RxSwift.framework/RxSwift @rpath/ThirdPartyLibraryManager.framework/ThirdPartyLibraryManager $RxNimbleRxTest2