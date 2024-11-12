//
//  String+.swift
//  DogWalk
//
//  Created by junehee on 11/4/24.
//

import SwiftUI

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
    
    // 채팅 텍스트에 따른 크기 조절
    func estimatedTextRect(width: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGRect {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let option: NSStringDrawingOptions = [
            .usesLineFragmentOrigin
        ]
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16.0, weight: .regular)
        ]
        return NSString(string: self).boundingRect(
            with: size,
            options: option,
            attributes: attributes,
            context: nil
        )
    }
}
