# 🐕 DogWalk
> ### 반려견 산책 기록 & 실시간 소통 커뮤니티 앱

<br />

## 📱 프로젝트 소개
> **개발 기간**: 2024.10.29 ~ 2024.11.30 (4주) <br/>
> **개발 인원**: 4인 (기획/디자인/개발)

<div align="center">
  <img width="24%" src="https://github.com/user-attachments/assets/adfaaa1b-860c-4179-9881-23d7f9f486a8" />
  <img width="24%" src="https://github.com/user-attachments/assets/d6dbb867-b9a5-4b24-84c2-0305ff5c5ead" />
  <img width="24%" src="https://github.com/user-attachments/assets/d0e6d92d-47ff-4215-b788-8fa7c1725dd8" />
  <img width="24%" src="https://github.com/user-attachments/assets/4213d091-e25d-4c99-979b-3d15bd37f8a3" />
</div>

<br />

## 🛠 기술 스택

### iOS
- **Language**: Swift 5.10
- **Framework**: SwiftUI
- **Minimum Target**: iOS 17.0

### 아키텍처 & 디자인 패턴
- **Architecture**: MVI
- **Design Pattern**: Repository Pattern, Coordinator Pattern

### 데이터베이스 & 네트워킹
- **Local Database**: CoreData
- **Network**: URLSession, Socket.IO
- **Location**: CoreLocation, MapKit
- **Weather**: WeatherKit

## 📋 주요 기능

### CoreLocation 기반 산책 기록 시스템
```swift
final class LocationManager: NSObject, CLLocationManagerDelegate {
    @Published var locations: [CLLocationCoordinate2D] = []
    @Published var isTrackingPath = false
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        if isTrackingPath {
            self.locations.append(coordinate)
            walkDistance += lastLocation.distance(from: newLocation)
        }
        lastLocation = newLocation
    }
}
```
- CoreLocation을 활용한 실시간 위치 추적 및 산책 경로 저장
- Background Location 모드로 백그라운드 위치 트래킹 지원
- 산책 거리, 시간, 칼로리 자동 계산

### 실시간 채팅 & 메시지 관리
```swift
final class ChatRepository {
    static let shared = ChatRepository(context: CoreDataManager.shared.viewContext)
    
    func createChatMessage(chatRoomID: String, messageData: ChattingModel) -> CoreDataChatMessage? {
        guard let chatRoom = fetchChatRoom(by: chatRoomID) else { return nil }
        let newMessage = CoreDataChatMessage(context: managedObjectContext)
        newMessage.chatID = messageData.chatID
        // ... 메시지 설정
        chatRoom.addToMessage(newMessage)
        saveContext()
        return newMessage
    }
}
```
- Socket.IO를 활용한 실시간 양방향 통신
- CoreData를 활용한 채팅 메시지 영구 저장
- 이미지 멀티파트 업로드 지원
- 앱 생명주기에 따른 소켓 연결 관리

### 백그라운드 작업 처리 시스템
```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.DogWalk2.background.socket", using: nil) { task in
            self.handleDisconnectSocket(task: task as! BGAppRefreshTask)
        }
        return true
    }
    
    func scheduleSocketDisconnectTask(after interval: TimeInterval) {
        let request = BGProcessingTaskRequest(identifier: "com.DogWalk2.background.socket")
        request.earliestBeginDate = Date(timeIntervalSinceNow: interval)
        try? BGTaskScheduler.shared.submit(request)
    }
}
```
- BGTaskScheduler를 활용한 백그라운드 작업 스케줄링
- DispatchSourceTimer를 활용한 백그라운드 타이머 구현
- 백그라운드 모드에서의 소켓 연결 관리

### CoreData 기반 데이터 영속성
```swift
@objc(CoreChatMessage)
public class CoreChatMessage: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(chatID, forKey: "chatID")
        coder.encode(content, forKey: "content")
        // ... 속성 인코딩
    }
}
```
- NSSecureCoding 프로토콜 구현으로 안전한 데이터 직렬화
- Custom Transformer를 활용한 복잡한 타입 저장
- Repository Pattern을 통한 데이터 접근 계층 추상화


## 🔧 시행착오

### 1. MapKit 카메라 상태 관리 최적화
#### 문제상황
- 앱 실행 시 현재 위치와 카메라 위치가 동시 업데이트되며 불필요한 `onMapCameraChange` 이벤트 발생
- 이로 인한 불필요한 API 호출과 새로고침 버튼 UI 깜빡임 현상
#### 해결방안
```swift
Map(position: $position) {
    // Map contents
}
.onMapCameraChange { context in
    if !state.position.followsUserLocation {
        intent.showRefreshButton()
    }
    
    if state.isTimerOn {
        intent.hideRefreshButton()
    }
}
```
- `followsUserLocation` 플래그를 활용한 카메라 상태 추적
- 산책 모드에서 불필요한 UI 업데이트 방지
- Intent 패턴을 활용한 상태 관리 일원화

### 2. WeatherKit 인증 및 권한 처리
#### 문제상황
- WeatherKit 개발자 계정 인증 오류 발생
- "WeatherDaemon.WDSJWTAuthenticatorServiceProxy.Errors error 0" 에러 메시지
#### 해결방안
```swift
class WeatherKitAPIManager {
    static let shared = WeatherKitAPIManager()
    private let weatherService = WeatherService.shared
    
    func fetchWeather(for location: CLLocation) async throws -> Weather {
        return try await weatherService.weather(for: location)
    }
    
    func translateCondition(_ condition: WeatherCondition) -> String {
        switch condition {
            case .clear: return "맑음"
            case .cloudy: return "흐림"
            // ... 다양한 날씨 상태 처리
        }
    }
}
```
- Apple Developer 계정의 WeatherKit 권한 활성화
- Capabilities 설정에서 WeatherKit 추가
- 날씨 데이터 국제화 및 현지화 처리

### 3. CoreData 멀티스레드 동기화
#### 문제상황
- 백그라운드 스레드에서 UI 업데이트 시도로 인한 크래시
- 채팅 메시지 저장 시 CoreData 컨텍스트 동시성 이슈
#### 해결방안
```swift
final class ChatRepository {
    private func saveContext() {
        guard managedObjectContext.hasChanges else { return }
        do {
            if Thread.isMainThread {
                try managedObjectContext.save()
            } else {
                managedObjectContext.performAndWait {
                    try? managedObjectContext.save()
                }
            }
        } catch {
            managedObjectContext.rollback()
            print("CoreData save error:", error)
        }
    }
}
```
- `performAndWait`를 활용한 스레드 안전성 확보
- 메인 스레드 체크를 통한 적절한 컨텍스트 접근
- 롤백 처리를 통한 데이터 일관성 유지

## 📝 회고

### 잘한 점
1. SwiftUI와 MVI 아키텍처로 깔끔한 상태관리
2. CoreData와 Socket.IO를 활용한 견고한 데이터 동기화
3. 백그라운드 처리를 통한 안정적인 산책 기록

### 아쉬운 점
1. 테스트 코드 부재
2. 에러 처리 체계 미흡
3. 메모리 누수 모니터링 부재

### 시도할 점
1. Unit Test 및 UI Test 도입
2. CI/CD 파이프라인 구축
3. 성능 모니터링 시스템 도입
