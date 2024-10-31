//
//  MapView.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    private static let width = UIScreen.main.bounds.width
    private static let height = UIScreen.main.bounds.height
    //임시 위치 설정
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
    )
    @State private var isShowingSheet = false // 임시 바텀 시트 변수
}

extension MapView {
    var body: some View {
        ZStack {
            mapView()
            timerBottomView()
                .vBottom()
        } //:ZSTACK
        .sheet(isPresented: $isShowingSheet) {
            userInfoBottomSheet()
                .presentationDetents([.fraction(0.3)])
        } //바텀시트
    }
}

// MARK: - 지도 관련 부분
private extension MapView {
    func mapView() -> some View {
        Map(position: $position) { //position: 표시할 지도 위치
            setAnnotation(lat: 37.5665, lng: 126.9780)
        }
    }
    //Annotation
    func setAnnotation(lat: Double, lng: Double) -> Annotation<Text, some View> {
        Annotation("", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng)) {
            customAnnotation()
        }
    }
    //커스텀 마커 이미지
    func customAnnotation() -> some View {
        VStack(spacing: 0) {
            Image.asTestLogo
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.primaryOrange)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.primaryOrange)
                .frame(width: 15, height: 15)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -6)
                .padding(.bottom, 40)
        }//:VSTACK
    }
}

// MARK: - 하단 버튼 뷰 부분
private extension MapView {
    //디폴트 프로필 + 산책 시작 버튼
    func defaultBottomView() -> some View {
        HStack {
            CommonProfile(image: .asTestProfile, size: 45)
            
            Spacer()
                .frame(width: 30)
            
            CommonButton(width: Self.width * 0.65, height: 44, cornerradius: 20, backColor: .primaryLime, text: "산책 시작하기", textFont: .pretendardBold14)
                .clipShape(RoundedRectangle(cornerRadius: 20)) // 버튼 모양에 맞게 그림자 조정
                .shadow(color: .black.opacity(0.6), radius: 5, x: 0, y: 5) // 버튼 그림자
                .wrapToButton {
                    print("산책 시작 버튼 클릭")
                }
            
        } //:HSTACK
        .padding(.bottom)
    }
    //타이머 시작 시 바텀 뷰
    func timerBottomView() -> some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.primaryGreen)
                .overlay {
                    Text("00:10:57") // 시간 넣기
                        .font(.pretendardBold16)
                        .foregroundStyle(.white)
                }
            Rectangle()
                .fill(Color.primaryLime)
                .overlay {
                    ZStack {
                        Rectangle()
                            .fill(Color.clear)
                            .wrapToButton {
                                print("산책 종료 버튼 클릭")
                                self.isShowingSheet.toggle()//임시 바텀시트 동작
                            }
                        Text("산책 종료")
                            .font(.pretendardBold16)
                    } //:ZSTACK
                }
        } //:HSTACK
        .frame(height: Self.height * 0.07)
    }
    //지도 마커 클릭 시 바텀 시트
    func userInfoBottomSheet() -> some View {
        VStack {
            HStack {
                CommonProfile(image: .asTestProfile, size: 65)
                    .padding(.leading)
                //게시글 유저 데이터
                userInfoTextField("도슈니", "믹스, 7세", mainFont: .pretendardBold16, subFont: .pretendardRegular13)
            } //:HSTACK
            .hLeading()
            
            Spacer()
                .frame(height: 15)
            //게시글 내용
            userInfoTextField("우리 아이는요 ", "겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???겁은 많지만 말량광량이???", 3, mainFont: .pretendardBold14, subFont: .pretendardRegular12)
                .padding(.horizontal)
            
            HStack(alignment: .center, spacing: 15) {
                CommonButton(width: Self.width * 0.55, height: 44, cornerradius: 20, backColor: .primaryLime, text: "작성한 게시물 보기", textFont: .pretendardBold14)
                    .wrapToButton {
                        print("게시글 보기 버튼 클릭")
                    }

                CommonButton(width: Self.width * 0.25, height: 44, cornerradius: 20, backColor: .primaryWhite, text: "멍톡 보내기", textFont: .pretendardBold14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.primaryGreen, lineWidth: 1) // 보더 색상과 두께 설정
                    )
                    .wrapToButton {
                        print("멍톡 보내기 클릭")
                    }
            } //:HSTACK
        } //:VSTACK
        .padding([.top])
        .vTop()
        .hLeading()
    }
    //바텀 시트 메인, 서브 텍스트 필드
    func userInfoTextField(_ mainText: String, _ subText: String, _ subTextLimit: Int = 1, mainFont: Font, subFont: Font) -> some View {
        VStack(alignment: .leading) {
            Text(mainText)
                .font(mainFont)
                .lineLimit(1)
            Spacer()
                .frame(height: 5)
            Text(subText)
                .font(subFont)
                .foregroundStyle(Color.gray) // 나중에 색 변경해주기
                .lineLimit(subTextLimit)
        } //:VSTACK
        
    }
}

#Preview {
    MapView()
}
