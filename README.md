# iOSApplicationTemplate

이 프로젝트는 Tuist를 이용하여 각 프로젝트를 모듈로 구성하는 형태입니다.

## 사용법

1.[Tuist 설치](https://github.com/tuist/tuist) - 버전 1.43.0 이상

2.[Carthage 설치](https://github.com/Carthage/Carthage) - 버전 0.38.0 이상  

3.`tuist dependencies`를 실행하여 XCFramework 생성

```
$ tuist dependencies fetch
Resolving and fetching dependencies.
Resolving and fetching Carthage dependencies.
...
Carthage dependencies resolved and fetched successfully.
Dependencies resolved and fetched successfully.
```

3.1. RxBlocking, RxTest를 Test 타겟에서 사용하기 위해 `install_name_tool`을 이용하여 `@rpath/RxSwift.framework/RxSwift`를 `@rpath/ThirdPartyLibraryManager.framework/ThirdPartyLibraryManager`로 교체함.

```
$ sh script/change-rpath-library.sh
```

4.`tuist generate`를 실행하여 프로젝트 파일 생성
```
$ tuist generate
```

## Dependency Graph

Tuist를 이용하여 Dependency Graph를 출력할 수 있음.

```
# Graph 생성
$ tuist graph

# 테스트 타겟 제외
$ tuist graph -t

# 외부 라이브러리 제외
$ tuist graph -d

# dot 파일로 출력
$ tuist graph -t -f dot
```

![graph](./graph.png)

## Design System

1.시험 라이브러리 목록
- [Square/Blueprint](https://github.com/square/Blueprint)
- [layoutBox/FlexLayout](https://github.com/layoutBox/FlexLayout)
- SwiftUI
- [Doric](https://github.com/jayeshk/Doric)

2. 디자인시스템 Ref
- https://medium.com/sketch-app-sources/setting-up-a-design-system-8729510def93
- https://ux.mailchimp.com/patterns/color

## 사용한, 사용할 오픈소스
* [RxViewBinder](https://github.com/magi82/RxViewBinder)

* 클린아키텍처 일부 설계 참고
  * https://app.diagrams.net/#G11kR-DSn8p-vpA-btOnlT2qm6Lq9Ph-ss
  * https://github.com/kudoleh/iOS-Clean-Architecture-MVVM.git
  * https://medium.com/@kimtaesoo188/android-clean-architecture-2e789d6cefc6, https://miro.medium.com/max/22442/1*FRgFgSG2mu4nRPyhwsPn3Q.png

* FlexLayout 사용법 참고
  * https://medium.com/swlh/a-swift-yogakit-guide-to-flexbox-fec74e1bffaf

## 주의

* FlexLayout은 FlexLayoutYoga, FlexLayoutYogaKit을 의존성으로 가지는데, 모듈맵에서 제대로 작성되지 않아, FlexLayout 프레임워크의 모듈맵에 FlexLayoutYoga, FlexLayoutYogaKit를 추가하였음. 따라서 수정요소가 있기 때문에 Vendor 경로에 추가함. (모듈맵 코드를 다시 복구 했는데, 또 잘 동작해서 왜 그런지는 모르겠음.)