//
//  MessageModel.swift
//  DogWalk
//
//  Created by 박성민 on 11/2/24.
//

import Foundation

struct MessageModel: Identifiable {
    
    enum MessageType: String {
        case text
        case image
    }
    
    let id: String = UUID().uuidString
    let message: String
    let userID: String
    let type: MessageType
    
}

@Observable
class Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return false
    }
    
    var modles: [MessageModel] = [
        MessageModel(message: "안녕!", userID: "나", type: .text),
        MessageModel(message: "오늘 정말 기분이 좋아요!", userID: "다른유저", type: .text),
        MessageModel(message: "이 사진 정말 멋지지 않나요?", userID: "나", type: .text),
        MessageModel(message: "새로 산 카메라로 찍어봤어요.", userID: "다른유저", type: .text),
        MessageModel(message: "와, 멋져요!", userID: "나", type: .text),
        MessageModel(message: "산책 가는 거 어때요?", userID: "다른유저", type: .text),
        MessageModel(message: "공원에서 만날까요?", userID: "나", type: .text),
        MessageModel(message: "이거 보세요!", userID: "다른유저", type: .image),
        MessageModel(message: "정말 멋지다!", userID: "나", type: .text),
        MessageModel(message: "모두가 즐거운 시간을 보낼 수 있도록 좋은 장소를 추천해 드릴게요.", userID: "다른유저", type: .text),
        MessageModel(message: "오늘 날씨가 너무 좋아서 밖에 나가 산책을 하고 싶어요.", userID: "나", type: .text),
        MessageModel(message: "오케이! 저도 준비할게요.", userID: "다른유저", type: .text),
        MessageModel(message: "가자!", userID: "나", type: .text),
        MessageModel(message: "새 카메라를 테스트하면서 정말 멋진 장면을 몇 장 찍었어요!", userID: "다른유저", type: .text),
        MessageModel(message: "좋아요!", userID: "나", type: .text),
        MessageModel(message: "이곳에 오면 정말 멋진 풍경을 볼 수 있을 거예요. 꼭 와봐요!", userID: "다른유저", type: .text),
        MessageModel(message: "네!", userID: "나", type: .text),
        MessageModel(message: "가까운 공원에서요.", userID: "다른유저", type: .text),
        MessageModel(message: "완전 좋아요! 모두 곧 만나요!", userID: "나", type: .text),
        MessageModel(message: "어제 밤에 찍은 사진인데 정말 멋진 순간을 포착했어요.", userID: "다른유저", type: .image),
        MessageModel(message: "완전 좋아요! 모두 곧 만나요!완전 좋아요! 모두 곧 만나요!완전 좋아요! 모두 곧 만나요!", userID: "나", type: .text),
        MessageModel(message: "어제 밤에 찍은 사진인데 정말 멋진 순간을 포착했어요.어제 밤에 찍은 사진인데 정말 멋진 순간을 포착했어요.어제 밤에 찍은 사진인데 정말 멋진 순간을 포착했어요.", userID: "다른유저", type: .image),
        MessageModel(message: "!", userID: "나", type: .text),
        MessageModel(message: "!", userID: "다른유저", type: .image),
        MessageModel(message: "배고파", userID: "다른유저", type: .image),
        MessageModel(message: "안녕!", userID: "나", type: .text),
        MessageModel(message: "오늘 정말 기분이 좋아요!", userID: "다른유저", type: .text),
        MessageModel(message: "이 사진 정말 멋지지 않나요?", userID: "나", type: .text),
        MessageModel(message: "새로 산 카메라로 찍어봤어요.", userID: "다른유저", type: .text),
        MessageModel(message: "와, 멋져요!", userID: "나", type: .text),
        MessageModel(message: "산책 가는 거 어때요?", userID: "다른유저", type: .text),
        MessageModel(message: "공원에서 만날까요?", userID: "나", type: .text),
        MessageModel(message: "이거 보세요!", userID: "다른유저", type: .image),
        MessageModel(message: "정말 멋지다!", userID: "나", type: .text),
        MessageModel(message: "모두가 즐거운 시간을 보낼 수 있도록 좋은 장소를 추천해 드릴게요.", userID: "다른유저", type: .text),
        MessageModel(message: "오늘 날씨가 너무 좋아서 밖에 나가 산책을 하고 싶어요.", userID: "나", type: .text),
        MessageModel(message: "오케이! 저도 준비할게요.", userID: "다른유저", type: .text),
        MessageModel(message: "가자!", userID: "나", type: .text),
        MessageModel(message: "새 카메라를 테스트하면서 정말 멋진 장면을 몇 장 찍었어요!", userID: "다른유저", type: .text),
        MessageModel(message: "좋아요!", userID: "나", type: .text),
        MessageModel(message: "이곳에 오면 정말 멋진 풍경을 볼 수 있을 거예요. 꼭 와봐요!", userID: "다른유저", type: .text),
        MessageModel(message: "네!", userID: "나", type: .text),
        MessageModel(message: "가까운 공원에서요.", userID: "다른유저", type: .text),
        MessageModel(message: "완전 좋아요! 모두 곧 만나요!", userID: "나", type: .text),
        MessageModel(message: "어제 밤에 찍은 사진인데 정말 멋진 순간을 포착했어요.", userID: "다른유저", type: .image),
        MessageModel(message: "완전 좋아요! 모두 곧 만나요!완전 좋아요! 모두 곧 만나요!완전 좋아요! 모두 곧 만나요!", userID: "나", type: .text),
        MessageModel(message: "어제 밤에 찍은 사진인데 정말 멋진 순간을 포착했어요.어제 밤에 찍은 사진인데 정말 멋진 순간을 포착했어요.어제 밤에 찍은 사진인데 정말 멋진 순간을 포착했어요.", userID: "다른유저", type: .image),
        MessageModel(message: "!", userID: "나", type: .text),
        MessageModel(message: "!", userID: "다른유저", type: .image),
        MessageModel(message: "배고파", userID: "다른유저", type: .image),
    ]
    func addMessage(text: String) {
        let random = Bool.random()
        self.modles.append(MessageModel(message: text, userID: random ? "나" : "다른유저", type: .text))
    }
}
