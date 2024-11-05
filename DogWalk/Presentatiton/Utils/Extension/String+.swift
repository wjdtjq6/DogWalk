//
//  String+.swift
//  DogWalk
//
//  Created by junehee on 11/4/24.
//

import Foundation

extension String {
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.InvalidURL }
        return url
    }
}
