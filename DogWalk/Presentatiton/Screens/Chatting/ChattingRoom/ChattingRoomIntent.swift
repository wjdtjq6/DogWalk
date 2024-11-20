//
//  ChattingRoomIntent.swift
//  DogWalk
//
//  Created by junehee on 11/12/24.
//

import SwiftUI

protocol ChattingRoomIntentProtocol {
    func onAppearTrigger(roomID: String)
    func sendTextMessage(roomID: String, message: String) async
    func onDisappearTrigger()
}

final class ChattingRoomIntent {
    private weak var state: ChattingRoomActionProtocol?
    private var useCase: ChattingRoomUseCase
    
    init(state: ChattingRoomActionProtocol, useCase: ChattingRoomUseCase) {
        self.state = state
        self.useCase = useCase
    }
}

extension ChattingRoomIntent: ChattingRoomIntentProtocol {
    // 채팅방 입장
    func onAppearTrigger(roomID: String) {
        print(#function, "멍톡 채팅방 진입")
        state?.changeViewState(state: .loading)
        /// 1) 최근 대화 날짜 가져오기
        let cursorDate = useCase.getCursorDate(roomID: roomID)
        print(cursorDate)
        Task {
            do {
                /// 2) 최근 대화 날짜 이후 채팅 데이터 요청
                let result = try await useCase.getChattingData(roomID: roomID, cursorDate: cursorDate)
                print("👇 최근 대화 요청 데이터")
                dump(result)
                /// 3) 응답 받은 채팅 데이터를 DB 저장
                useCase.updateChattingData(roomID: roomID, data: result)
                /// 4) DB에 저장된 전체 채팅 데이터 가져온 후 State 전달
                let chattingData = useCase.getAllChattingData()
                print("👇 DB에 저장된 전체 채팅 데이터")
                print(chattingData)
                state?.updateChattingData(data: chattingData)
                /// 5) Socket 연결
                useCase.openSocket(roomID: roomID)
            } catch  {
                print(#function, error)
                state?.changeViewState(state: .error)
            }
        }
        
    }
    
    // 텍스트 메세지 전송
    func sendTextMessage(roomID: String, message: String) async {
        print(#function, "채팅 전송 버튼 클릭")
        Task {
            do {
                let result = try await useCase.sendTextMessage(roomID: roomID, message: message)
                print("채팅 전송 완료 + CoreData에 저장")
                print(result)
            } catch  {
                print(#function, error)
                state?.changeViewState(state: .error)
            }
        }
    }
    
    func sendImageMessage(roomID: String, image: UIImage) {
        Task {
            do {
                guard let jpegData = image.jpegData(compressionQuality: 10) else { return }
                let result = try await useCase.sendImageMessage(roomID: roomID, image: jpegData)
                print(result)
            } catch {
                print(#function, error)
            }
        }
    }
    
    // 채팅방 퇴장 - Socket Close
    func onDisappearTrigger() {
        useCase.closeSocket()
    }
}
