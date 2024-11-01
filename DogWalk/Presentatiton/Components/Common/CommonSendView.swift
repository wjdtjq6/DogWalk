//
//  CommonSendView.swift
//  DogWalk
//
//  Created by 박성민 on 11/1/24.
//

import SwiftUI

struct CommonSendView: View {
    var proxy: GeometryProxy
    @State private var text = ""
    @State private var bottomPadding: CGFloat = 0.0
    @State private var sendHeigh: CGFloat = 36.0
    @State private var showKeyboard = false //키보드 여부
    @State private var isSendable = false // 보내기 버튼 활성화 여부
    @State private var isCamera = false //카메라 클릭 여부
    private let tfHeight: CGFloat = 36.0
    private var size: CGSize {
        return proxy.size
    }
    var completionSendText: ((String) -> ())?
    
    var body: some View {
        let bottomSafeArea = UIApplication.shared.bottomPadding
        HStack(alignment: .bottom, spacing: 10.0) {
            cameraButton()
            textField()
            sendButton()
        }
        .padding([.top, .leading, .trailing], 10.0)
        .padding(.bottom, bottomSafeArea + bottomPadding + 10)
        .background(Color.primaryWhite)
        .clipShape(.rect(
            topLeadingRadius: 20.0,
            topTrailingRadius: 20.0)
        )
        .shadow(radius: 1.0, y: -1.0)
        .offset(y: size.height - (bottomSafeArea + bottomPadding + sendHeigh - (bottomPadding == 0 ? -20 : 14)))
        .onReceive(NotificationCenter.default.publisher(for: .keyboardWillShow), perform: { notif in
            //keyboard 높이에 따른 bottom 높이 조절
            if let keyboardHeight = (notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height,
               let duration = (notif.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
            {
                withAnimation(.snappy(duration: duration)) {
                    bottomPadding = keyboardHeight
                    showKeyboard = true
                }
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: .keyboardWillHide), perform: { notif in
            if let duration = (notif.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
            {
                withAnimation(.snappy(duration: duration)) {
                    bottomPadding = 0.0
                    showKeyboard = false
                }
            }
        })
    }
}
// MARK: - 텍스트 부분
private extension CommonSendView {
    @ViewBuilder
    func textField() -> some View {
        HStack {
            TextField(
                "메세지를 입력하세요",
                text: $text,
                axis: .vertical
            )
            .font(.pretendardRegular16)
            .lineLimit(showKeyboard ? 4 : 1)
            .tint(.primaryBlack)
            .onChange(of: text) { oldValue, newValue in
                //엔터만 누를경우 보내기 막기
                if !newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    text = newValue
                } else {
                    text = ""
                }
                isSendable = !text.isEmpty
            }
        } //:HSTACK
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frame(minHeight: tfHeight)
        .background(
            GeometryReader {
                Color.gray.opacity(0.1)
                    .preference(key: TextFieldSize.self, value: $0.size)
                    .onPreferenceChange(TextFieldSize.self, perform: { value in
                        sendHeigh = value.height
                    })
            }
            
        )
        .clipShape(.rect(cornerRadius: tfHeight / 2))
        .animation(.easeInOut(duration: 0.2), value: showKeyboard)
    }
}
// MARK: - 카메라 부분
private extension CommonSendView {
    @ViewBuilder
    func cameraButton() -> some View {
        Button {
            // Action
        } label: {
            Image(systemName: "camera.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .aspectRatio(0.65, contentMode: .fit)
        }
        .buttonStyle(.plain)
        .frame(width: tfHeight, height: tfHeight)
    }
}
// MARK: - 보내기 버튼 부분
private extension CommonSendView {
    @ViewBuilder
    func sendButton() -> some View {
        Button {
            if isSendable {
                self.completionSendText?(text)
                self.text = ""
            }
        } label: {
            Image(systemName: "paperplane")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .aspectRatio(0.65, contentMode: .fit)
                .foregroundStyle(isSendable ? Color.green : Color.primaryGray)
        }
        .buttonStyle(.plain)
        .frame(width: tfHeight, height: tfHeight)
        .offset(x: -4)
    }
}

#Preview {
    ChattingRoomView()
}

extension Notification.Name {
    static let keyboardWillShow = UIResponder.keyboardWillShowNotification
    static let keyboardWillHide = UIResponder.keyboardWillHideNotification
}
// MARK: - 키보드 감지 부분
extension UIApplication {
    var KeyWindow: UIWindow {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene}
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })
        ??
        UIWindow()
    }
    
    var topPadding: CGFloat {
        return UIApplication.shared.KeyWindow.safeAreaInsets.top
    }
    var bottomPadding: CGFloat {
        return UIApplication.shared.KeyWindow.safeAreaInsets.bottom
    }
}

struct TextFieldSize: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
