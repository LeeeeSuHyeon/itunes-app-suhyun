# itunes-app-suhyun

### iTunes Search API를 활용하여 음악, 영화, 팟캐스트에 대한 정보 검색과 미리보기 기능을 제공하는 앱입니다. 
### 개발기간: 2025.05.07 ~ 2025.05.19
## 구현 화면
<table>
  <tr>
    <td align="center">메인 화면(음악 추천)</td>
    <td align="center">검색 결과 화면</td>
    <td align="center">상세 정보 화면</td>
  </tr>
  <tr>
    <td style="text-align: center;">
        <img src="https://github.com/user-attachments/assets/8df182bf-ff5a-4d7b-b3a3-0d27d72b4bb0" width="300"/>
    </td>
    <td style="text-align: center;">
        <img src="https://github.com/user-attachments/assets/419c1db1-77c6-44b3-84e4-0942e4a2e779" width="300"/>
    </td>
    <td style="text-align: center;">
        <img src="https://github.com/user-attachments/assets/12ed2085-828b-412f-ad90-01e1935c444c" width="300"/>
    </td>

  </tr>
</table>

## 프로젝트 아키텍처
![Image](https://github.com/user-attachments/assets/b0356509-ef2c-4fe2-a3d8-4e211e4011f2)
 

## 기술 스택
| Name          | Description   |
| ------------  | ------------- |
| **UIKit** | iOS 앱의 UI를 구축하고 사용자 인터페이스를 관리하는 기본 프레임워크 |
| **SnapKit** | Auto Layout 제약 조건을 간결하게 선언하여 코드의 가독성과 유지보수성을 높이기 위해 사용|
| **RxSwift** | 비동기 이벤트 흐름을 선언적으로 처리하고 다양한 Operator로 반응형 프로그래밍 구현을 위해 사용 |


## 파일구조
``` 
iTunesAppSuhyun
 ┣ App
 ┃ ┣ AppDelegate
 ┃ ┣ DIContainer
 ┃ ┗ SceneDelegate
 ┣ Data
 ┃ ┣ ErrorType // NetworkError Type
 ┃ ┣ Extensions
 ┃ ┣ Network
 ┃ ┃ ┣ Base
 ┃ ┃ ┣ DTO
 ┃ ┃ ┗ ITunesNewtork
 ┃ ┗ Repository
 ┣ Domain
 ┃ ┣ Model
 ┃ ┣ RepositoryProtocol
 ┃ ┗ UseCase
 ┣ Presentation
 ┃ ┣ Detail
 ┃ ┣ Home
 ┃ ┣ SearchResult
 ┃ ┗ Util
 ┃ ┃ ┣ Extensions
 ┃ ┃ ┗ ImageLoader // 이미지 캐시
 ┗ Resource
 ┃ ┣ Assets.xcassets
 ┃ ┣ Base.lproj
 ┗ ┗ Info.plist
 ```

## 상세 화면 레이아웃 구조
<table>
  <tr>
    <td style="text-align: center;">
        <img src="https://github.com/user-attachments/assets/f43fba5b-5fa7-4c9a-a028-b264e0def05d" width="400"/>
    </td>
    <td style="text-align: center;">
        <img src="https://github.com/user-attachments/assets/945a673e-a25f-4cf5-8b3c-a353457f896b" width="400"/>
    </td>
  </tr>
</table>


## Clean Architecture를 활용한 모듈화 (Modularity)
본 프로젝트는 Clean Architecture를 기반으로 명확한 책임 분리를 통해 모듈화를 구현했습니다.
- Presentation, Domain, Data, App 레이어로 나누어 기능별로 모듈화했으며, 각 레이어는 의존성 방향을 지키며 느슨하게 결합되어 있습니다. 
- NetworkSerivce, Repository, UseCase 등이 각기 다른 책임을 가지므로 유지 보수와 테스트가 용이한 구조입니다.

실제 기능을 추가하고 테스트를 진행하면서 명확한 책임 분리와 모듈간 의존성을 최소화한 Clean Architecture의 장점을 느낄 수 있었습니다.
``` 
iTunesAppSuhyun
 ┣ App          // 앱의 진입점, 의존성 관리
 ┣ Data         // Repository, Network 구현
 ┣ Domain       // Model, UseCase, RepositoryProtocol 구현
 ┣ Presentation // ViewController, View, ViewModel 구현
 ┗ Resource     // Assets, info.plist 등
 ```

## 프로토콜 기반 추상화 (Abstraction)
프로젝트 전반에 걸쳐 의존성 역전 원칙(DIP)을 따르기 위해 프로토콜 기반 추상화를 적용했습니다.  
예를 들어, 고수준 모듈인 UseCase가 저수준 모듈인 Repository를 의존하게 되면 DIP에 위배되어 유지보수가 비효율적일 수 있습니다.   
따라서 Repository를 프로토콜로 추상화하여 UseCase에서 Repository Protocol을 의존하게 되면 DIP 원칙을 지키면서 유지보수성이 높아질 수 있습니다.  

```swift 
// Domain Layer
protocol MovieRepositoryProtocol {
    func fetchMovie(keyword: String, country: String, limit: Int) async throws -> [Movie]
}

// Data Layer
final class MovieRepository: MovieRepositoryProtocol {
    // 실제 구현부
    func fetchMovie(keyword: String, country: String, limit: Int) async throws -> [Movie] {
        ...
    }
}
```

## 테스트
모듈화를 활용한 책임 분리, 추상화, 의존성 주입으로 테스트 용이성을 직접 체감했습니다.   
본 테스트에서는 UseCase, Repository 테스트 보단 Network의 테스트에 중점을 두어 진행했습니다.  
Network 테스트 진행 과정에서 **expectation, wait을 활용한 비동기 테스트** 구현 방법을 학습할 수 있었습니다.  
[테스트 코드 바로가기 👉](https://github.com/nbcamp-letswork/itunes-app-suhyun/tree/main/iTunesAppSuhyun/iTunesAppSuhyunTests)


## 이미지 캐시
### NSCache, Actor를 활용하여 이미지 캐시를 직접 구현했습니다. 
imageURL을 Key, UIImage를 Value로 NSCache에 저장하여 동일한 URL의 이미지를 반복 다운로드 하지 않고 캐시된 이미지를 반환해 이미지 로딩 시간을 줄였습니다.  
NSCache는 메모리 캐시로 앱이 실행되는 동안에만 캐시가 유지되며, 앱 종료 시 모든 캐시가 소멸됩니다.  
Actor를 사용하여 이미지 중복 다운로드를 방지하고 만료 기간을 저장하여 여러 스레드에서 접근해도 캐시 데이터의 일관성을 유지했습니다.  
TTL(Time-To-Live)을 설정하여 캐시 만료 시점을 관리하고, 캐시 메모리의 용량을 제한하여 메모리를 효율적으로 관리할 수 있도록 설계했습니다.  
[이미지 캐시 코드 바로가기 👉](https://github.com/nbcamp-letswork/itunes-app-suhyun/tree/main/iTunesAppSuhyun/iTunesAppSuhyun/Presentation/Util/ImageLoader)


## 메모리 누수 디버깅
### 현재 DetailViewController를 여러 번 호출하고 dismiss를 해도 DetailViewController와 관련된 객체들이 메모리에서 해제되지 않아 메모리 누수가 발생했습니다.

### Debug Memory Graph
![Image](https://github.com/user-attachments/assets/8a52221a-7e76-4879-a247-1f78d5a99e6c)

DetailViewController가 제대로 deinit되지 않아 내부 객체들도 메모리에서 해제되지 않았습니다.  
DetailViewController의 하위뷰인 PreviewView에서 영상 재생을 위해 딜리게이트 패턴이 사용되었는데 이때 순환참조가 발생했었습니다.  

```swift
// PrevieView.swift
var delegate: PreviewViewDelegate?
```

순환참조를 막기 위해 약한 참조로 선언하여 순환 참조 문제를 해결했습니다
```swift
// PrevieView.swift
weak var delegate: PreviewViewDelegate?
```

### 메모리 누수 해결
![Image](https://github.com/user-attachments/assets/ebb49f0b-b32b-449a-a9af-bf50cad293f5)

## 시연영상
![Image](https://github.com/user-attachments/assets/b67e97b2-beb9-42f6-92d1-eab4fdbe69b9)

## TIL / 트러블 슈팅
- [Swift Concurrency를 이용한 네트워크 병렬 처리 방법 비교](https://soo-hyn.tistory.com/150)
- [Itunes Search API의 이미지 저해상도 👉 고해상도로 변경](https://soo-hyn.tistory.com/151)
- [Swift Concurrency Instruments 활용하여 동시성 최적화](https://soo-hyn.tistory.com/162)
