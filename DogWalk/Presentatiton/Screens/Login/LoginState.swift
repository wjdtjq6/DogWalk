//
//  LoginState.swift
//  DogWalk
//
//  Created by junehee on 11/11/24.
//

import Foundation
import Combine

protocol LoginStateProtocol {
    var isLoginDone: Bool { get }
}

protocol LoginActionProtocol: AnyObject {
    func login(id: String, pw: String) async
}

@Observable
final class LoginState: LoginStateProtocol, ObservableObject {
    private let network = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    var isLoginDone: Bool = false
}

extension LoginState: LoginActionProtocol {
    func login(id: String, pw: String) async {
        print("로그인 요청 실행")
        do {
            let body = EmailLoginBody(email: id, password: pw)
            let future = try await network.request(target: .user(.emailLogin(body: body)), of: OAuthLoginDTO.self)
            
            future
                .sink { result in
                    switch result {
                    case .finished:
                        print("✨ 로그인 성공")
                    case .failure(let error):
                        print("🚨 로그인 실패", error)
                    }
                } receiveValue: { [weak self] data in
                    // 로그인 성공 응답값을 UserDefaults에 저장
                    print("유저디폴트에 저장")
                    UserManager.shared.acess = data.accessToken
                    UserManager.shared.refresh = data.refreshToken
                    UserManager.shared.isUser = true
                    self?.isLoginDone = true
                    print("유저디폴트에 저장 완료")
                }
                .store(in: &cancellables)
        } catch {
            print("로그인 요청 실패", error)
        }
    }
}

