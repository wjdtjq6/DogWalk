//
//  NetworkManager.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import Foundation
import Combine

protocol Requestable {
    func request<T: Decodable>(target: APITarget, of type: T.Type) async throws -> Future<T, NetworkError>
}

protocol SessionDatable {
    /**
     `public func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)? = nil) async throws -> (Data, URLResponse)`
     원래는 위와 같이 delegate를 받는 메서드로, task가 끝난 후 callback을 통해 delegate에게 전달하지만
     우리 프로젝트는 async-await를 통해 비동기 작업을 수행하기 때문에 메서드에 deleate를 삭제합니다!
     */
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

// URLSession에 SessionDatable 프로토콜을 채택해주기 위한 익스텐션
extension URLSession: SessionDatable { }

// 네트워크 호출 매니저
final class NetworkManager: Requestable {

    private let session: SessionDatable
    private var cancellables = Set<AnyCancellable>()

    init(session: SessionDatable = URLSession.shared) {
        self.session = session
    }

    func request<T>(target: APITarget, of type: T.Type) async throws -> Future<T, NetworkError> where T: Decodable {
        return Future { promise in
            Task {
                do {
                    print("1️⃣ URLRequest 생성 시작")
                    guard let request = try? target.asURLRequest() else {
                        print("🚨 리퀘스트 생성 실패")
                        promise(.failure(.InvalidRequest))
                        return
                    }

                    print("✨ URLRequest 생성 성공")
                    print("2️⃣ 네트워크 요청 시작")
                    let (data, response) = try await self.session.data(for: request)

                    print("3️⃣ 네트워크 응답 받음")
                    print(data)
                    print(response)
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        print("🚨 유효하지 않은 응답")
                        promise(.failure(.InvalidResponse))
                        return
                    }

                    print("4️⃣ 데이터 디코딩 시작")
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        print("✨ 데이터 디코딩 성공")
                        promise(.success(decodedData))
                    } catch {
                        print("🚨 데이터 디코딩 실패", error)
                        promise(.failure(.DecodingError))
                    }

                } catch {
                    print("🚨 네트워크 요청 실패: \(error)")
                    promise(.failure(.InvalidRequest))
                }
            }
        }
    }
    
    // 내 프로필 조회 함수 예시!
    func fetchProfile() async {
        do {
            let future = try await request(target: .user(.myProfile), of: MyProfileDTO.self)
            future
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("프로필 요청 완료")
                    case .failure(let error):
                        print("프로필 요청 실패: \(error)")
                    }
                } receiveValue: { profileData in
                    print("성공적으로 가져온 프로필 데이터: \(profileData)")
                }
                .store(in: &cancellables)
        } catch {
            print("프로필 요청 생성 실패: \(error)")
        }
    }
}


// MARK: 네트워크 재시도 함수 (추후 연결할 것!)
final class NetworkRetryHandler {
    private let maxRetryCount: Int
    private var retryCount: Int
    
    init(maxRetryCount: Int = 3, retryCount: Int = 0) {
        self.maxRetryCount = maxRetryCount
        self.retryCount = retryCount
    }
    
    func shouldRetry(for error: Error) -> Bool {
        if retryCount < maxRetryCount {
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet, .timedOut, .networkConnectionLost:
                    return true
                default:
                    return false
                }
            }
        }
        return false
    }
    
    func incrementRetryCount() {
        retryCount += 1
    }
}
