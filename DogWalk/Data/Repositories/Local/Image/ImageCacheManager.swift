//
//  ImageCacheManager.swift
//  DogWalk
//
//  Created by 박성민 on 11/11/24.
//

import SwiftUI

final class ImageCacheManager {
    private var urlSession: URLSession
    private let cache: URLCache
    
    init(urlSession: URLSession = URLSession(configuration: .ephemeral), cache: URLCache = URLCache(memoryCapacity: 40 * 1024 * 1024, diskCapacity: 400 * 1024 * 1024)) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    func getImage(_ urlStr: String) async -> UIImage {
        guard let url = URL(string: APIKey.baseURL + urlStr) else { return .test }
        if let cacheImage = try? await getToCache(url: url) { //캐싱된 이미지 가져옴
            return cacheImage
        }
        if let documentImage = getToDocument(id: urlStr) { //document의 id에 baseURL 포함 유무 확인하기
            return documentImage
        }
        
        return .test
    }
}

private extension ImageCacheManager {
    func getToCache(url: URL) async throws -> UIImage? {
        let request = URLRequest(url: url)
        if let cacheData = cache.cachedResponse(for: request)?.data, let image = UIImage(data: cacheData) {
            print("캐싱 이미지 가져옴")
            return image
        } else {
            return try await fetchImage(url: url)
        }
    }
    
    //캐시된 이미지가 아닌경우 네트워킹
    func fetchImage(url: URL) async throws -> UIImage? {
        let network = NetworkManager()
        var request = URLRequest(url: url)
        request.addValue(APIKey.key, forHTTPHeaderField: BaseHeader.sesacKey.rawValue)
        request.addValue(APIKey.appID, forHTTPHeaderField: BaseHeader.productId.rawValue)
        request.addValue(UserManager.shared.acess, forHTTPHeaderField: BaseHeader.authorization.rawValue)
        request.addValue(BaseHeader.json.rawValue, forHTTPHeaderField: BaseHeader.contentType.rawValue)
        
        let (data, response) = try await urlSession.data(for: request)
        guard let httpURLResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        if httpURLResponse.statusCode == 200 {
            print("네트워크 후 가져옴")
            let image = UIImage(data: data)
            saveToCache(url: url, response: response, data: data)
            return image
        } else if httpURLResponse.statusCode == 419 { //토큰 갱신
            if await network.refreshToken() {
                print("토큰 갱신")
                return try await fetchImage(url: url)
            }
        } else {
            throw URLError(.badServerResponse)
        }
        return .test
    }
    // 네트워크 후 캐싱
    func saveToCache(url: URL, response: URLResponse, data: Data) {
        let request = URLRequest(url: url)
        let cachedURLResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedURLResponse, for: request)
    }
    //Document에서 id로 이미지 가져오기
    func getToDocument(id: String) -> UIImage? {
        print("Document에서 가져옴")
        return .test
    }
}
