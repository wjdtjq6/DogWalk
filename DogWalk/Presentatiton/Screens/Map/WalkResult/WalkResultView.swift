//
//  WalkResultView.swift
//  DogWalk
//
//  Created by 박성민 on 10/31/24.
//

import SwiftUI
import MapKit

struct WalkResultView: View {
    private static let width = UIScreen.main.bounds.width
    private static let height = UIScreen.main.bounds.height
    @StateObject var container: Container<WalkResultIntentProtocol, WalkResultStateProtocol>
    private var state: WalkResultStateProtocol { container.state }
    private var intent: WalkResultIntentProtocol { container.intent }
    
    //임시 위치 설정.
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
    )
}

extension WalkResultView {
    static func build(walkTime: Int, walkDistance: Double) -> some View {
        let state = WalkResultState(walkTime: walkTime, walkDistance: walkDistance)
        let intent = WalkResultIntent(state: state)
        let container = Container(
            intent: intent as WalkResultIntentProtocol,
            state: state as WalkResultStateProtocol,
            modelChangePublisher: state.objectWillChange
        )
        let view = WalkResultView(container: container)
        return view
    }
}

extension WalkResultView {
    var body: some View {
        VStack {
            topView()
            ScrollView {
                userProfileView()
                Spacer()
                    .frame(height: 40)
                infos()
                Spacer()
                    .frame(height: 40)
                warkMapView()
                setPostButtonView()
                Spacer()
            }
        }
    }
}
// MARK: - 상단 뷰 부분
private extension WalkResultView {
    func topView() -> some View {
        HStack {
            Text(state.postDate) // 날짜
                .font(.pretendardBold16)
                .lineLimit(1)
                .padding(.leading)
                .hLeading()
            
            Image.asXmark
                .foregroundStyle(Color.primaryBlack)
                .frame(width: 40, height: 40)
                .hTrailing()
                .padding(.trailing)
                .wrapToButton {
                    intent.dismissButtonTap()
                }
        } //:HSTACK
    }
    func userProfileView() -> some View {
        VStack(spacing: 30) {
            Text("우리 아이와 함께 산책하는\n여러분의 멋진 하루를 응원해요!")
                .font(.pretendardBold20)
                .hLeading()
                .padding(.horizontal, 30)
            HStack {
                CommonProfile(image: .asTestImage, size: 30)
                Text("\(state.dogNick)과 함께 산책했어요!") // 강아지 닉네임 입력
                    .font(.pretendardBold15)
                    .lineLimit(1)
            } //:HSTACK
            .hLeading()
            .padding(.horizontal, 30)
        } //:VSTACK
    }
    
}
// MARK: - 산책 정보
private extension WalkResultView {
    //정보들
    func infos() -> some View {
        HStack(spacing: 35) {
            info(top: "산책 시간", mid: "\(state.walkTime/60)", bottom: "min")
            
            Rectangle()
                .fill(Color.primaryGray)
                .frame(width: 1, height: 60)
            
            info(top: "거리", mid: "\(state.walkDistance.rounded()/1000)", bottom: "km")
            
            Rectangle()
                .fill(Color.primaryGray)
                .frame(width: 1, height: 60)
            
            info(top: "칼로리", mid: "\(Int(state.walkCalorie))", bottom: "kcal")
                .onAppear {
                    intent.calculateCalories()
                }
            
        } //:HSTACK
    }
    //각각의 정보
    func info(top: String, mid: String, bottom: String) -> some View {
        VStack(spacing: 10) {
            Text(top)
                .font(.pretendardBold12)
                .foregroundStyle(Color.primaryBlack)
            Text(mid)
                .font(.pretendardSemiBold20)
                .foregroundStyle(Color.primaryBlack)
            Text(bottom)
                .font(.pretendardRegular14)
                .foregroundStyle(Color.primaryBlack)
        } //:VSTACK
    }
}
// MARK: - 산책 지도 부분
private extension WalkResultView {
    func warkMapView() -> some View {
        Map(position: $position) { //position: 표시할 지도 위치
            //맵에 추가적인 정보
        }
        .frame(width: Self.width * 0.9, height: Self.height * 0.25)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    func setPostButtonView() -> some View {
        ZStack {
            Rectangle()
                .frame(width: Self.width * 0.9, height: Self.height * 0.165)
                .foregroundStyle(Color.primaryLime)
                .overlay (
                    setPostView()
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
        } //:VSTACK
    }
    //작성하기 버튼 + 이미지???
    func setPostView() -> some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Image.asTestImage
                    .resizable()
                    .frame(width: Self.width * 0.3, height: Self.height * 0.1)
                Text("오늘 함께 한 샌책을\n기록하러 갈까요?")
                    .font(.pretendardRegular14)
                    .foregroundStyle(Color.primaryOrange).opacity(0.8)
            } //:HSTACK
            CommonButton(width: Self.width * 0.9, height: Self.height * 0.06, cornerradius: 0, backColor: .primaryOrange, text: "게시글 작성하기", textFont: .pretendardBold16, textColor: .primaryWhite, leftLogo: .asPlus, imageSize: 15)
                .foregroundStyle(Color.primaryWhite)
                .wrapToButton {
                    print("게시글 작성 탭함")
                }
        } //:VSTACK
    }
}

//#Preview {
//    WarkResultView()
//}
