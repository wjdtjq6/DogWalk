//
//  String+.swift
//  DogWalk
//
//  Created by junehee on 11/4/24.
//

import Foundation

extension String {
    //TODO: 원하는 형태의 포맷 타입으로 설정 후 팀원에게 공유해주세요 ^_^
    enum DateFormatType: String {
        case dot = "yyyy. MM. dd"
        case dash = "yyyy-MM-dd"
        case yearMonth = "YYYY MMMM"
    }

    // String -> URL
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.InvalidURL }
        return url
    }
    
    // String -> Date -> String
    func getFormattedDateString(_ formatType: DateFormatType = .dot) -> String {
        return self
    }
}
