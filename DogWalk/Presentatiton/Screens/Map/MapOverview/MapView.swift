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
    @State var isShowingSheet = false // 임시 바텀 시트 변수
    //Timer
    @State private var start = false
    @State private var to: CGFloat = 0
    @State private var count = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isTimerOn = false
    @State private var isAlert = false
    //현위치
    @StateObject private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var polylineColor: Color = Color(
        red: Double.random(in: 0...1),
        green: Double.random(in: 0...1),
        blue: Double.random(in: 0...1)
    )
}

extension MapView {
    var body: some View {
        ZStack {
            mapView()
            if isTimerOn {
                timerBottomView()
                    .vBottom()
            } else {
                defaultBottomView()
                    .vBottom()
            }
        } //:ZSTACK
        .fullScreenCover(isPresented: $isShowingSheet, content: {
            /*
             보낼거
             1. 산책시간
             2. 거리(랑 시간 계산해서 칼로리)
             3. Polyline자체 or 캡쳐해서 사진으로
             4. Polyline의 중간을 cameraposition으로
             */
            WalkResultView.build()
        })
    }
}

// MARK: - 지도 관련 부분
private extension MapView {
    func mapView() -> some View {
        Map(position: $position) { //position: 표시할 지도 위치
            UserAnnotation()
            
            if locationManager.locations.count > 1 {
                let polylineCoordinates = locationManager.locations
                MapPolyline(coordinates: polylineCoordinates)
                    .stroke(polylineColor, lineWidth: 5)
            }
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
                    if locationManager.locationManager.authorizationStatus == .authorizedAlways || locationManager.locationManager.authorizationStatus == .authorizedWhenInUse {
                        isTimerOn = true//Timer
                        count = 0
                        start = true
                        locationManager.isTrackingPath = true // 경로 기록 시작
                        locationManager.resetLocations() // 이전 기록 초기화
                    } else {
                        isAlert = true
                    }
                }
                .alert("위치 권한 허용하러 갈멍?", isPresented: $isAlert) {
                    Button("이동", role: .destructive) {
                        openAppSettings()
                    }
                    Button("취소", role: .cancel) {
                    }
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
                    let hours = self.count / 3600
                    let minutes = String(format: "%02d", (self.count % 3600) / 60)
                    let seconds = String(format: "%02d", self.count % 3600 % 60)
                    Text("\(hours):\(minutes):\(seconds)") // 시간 넣기
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
                                self.isTimerOn.toggle()//Timer
                            }
                        Text("산책 종료")
                            .font(.pretendardBold16)
                    } //:ZSTACK
                }
        } //:HSTACK
        .frame(height: Self.height * 0.07)
        //Timer
        .onReceive(self.timer, perform: { _ in
            if self.start {
                if self.count < 6 * 60 * 60 {//6시간까지 count
                    self.count += 1
                    print(self.count)
                }
                else {
                    self.start.toggle()
                }
            }
        })
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
    //위치 권한 허용하기 위한 설정으로 이동
    func openAppSettings() {
        if let appSettingURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettingURL) {
                UIApplication.shared.open(appSettingURL)
            }
        }
    }
}

//MARK: - 위치 권한 부분
private extension MapView {
    
}

#Preview {
    MapView()
}
