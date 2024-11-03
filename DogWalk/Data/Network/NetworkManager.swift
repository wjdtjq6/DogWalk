//
//  NetworkManager.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import Foundation
import Combine

protocol NetworkCall {
    // func callRequest<T: Decodable>(target: APITarget, of type: T.Type) async throws -> Result<T, NetworkError>
    // func callRequest<T: Decodable>(router: Router, type: T.Type) -> Single<Result<T, NetworkError>>
}

final class NetworkManager: NetworkCall {
    static let shared = NetworkManager()
    private init() { }
}

