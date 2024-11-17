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
    @StateObject var container: Container<MapIntentProtocol, MapStateProtocol>
    private var state: MapStateProtocol { container.state }
    private var intent: MapIntentProtocol { container.intent }
    @EnvironmentObject var coordinator: MainCoordinator
}

extension MapView {
    var body: some View {
        ZStack {
            mapView()
            if state.isTimerOn {
                timerBottomView()
                    .vBottom()
            } else {
                defaultBottomView()
                    .vBottom()
            }
        } //:ZSTACK
    }
}

// MARK: - 지도 관련 부분
private extension MapView {
    func mapView() -> some View {
        Map(position: Binding(get: {
            state.position
        }, set: { _ in
        })) { //position: 표시할 지도 위치
            UserAnnotation()
            
            if state.locationManager.locations.count > 1 {
                let polylineCoordinates = state.locationManager.locations
                MapPolyline(coordinates: polylineCoordinates)
                    .stroke(state.polylineColor, lineWidth: 5)
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
                    if state.locationManager.locationManager.authorizationStatus == .authorizedAlways || state.locationManager.locationManager.authorizationStatus == .authorizedWhenInUse {
                        intent.startWalk()
                    } else {
                        intent.showAlert()
                    }
                }
                .alert("위치 권한 허용하러 갈멍?", isPresented: Binding(get: {
                    state.isAlert
                }, set: { newAlert in
                    if !newAlert {
                        intent.closeAlert()
                    }
                })) {
                    Button("이동", role: .destructive) { intent.openAppSettings() }
                    Button("취소", role: .cancel) {}
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
                    let hours = state.count / 3600
                    let minutes = String(format: "%02d", (state.count % 3600) / 60)
                    let seconds = String(format: "%02d", state.count % 3600 % 60)
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
                                await intent.setRouteImage(route: state.locationManager.locations)
                                intent.stopWalk()
                                coordinator.push(.dogWalkResult(walkTime: state.count, walkDistance: state.locationManager.walkDistance, routeImage: state.routeImage))
                            }
                        Text("산책 종료")
                            .font(.pretendardBold16)
                    } //:ZSTACK
                }
        } //:HSTACK
        .frame(height: Self.height * 0.07)
        //Timer
        .onReceive(state.timer, perform: { _ in
            if state.count < 6 * 60 * 60 {//6시간까지 count
                intent.incrementTimer()
                print(state.count)
            }
            else {
                intent.stopWalk()
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
}

extension MapView {
    static func build() -> some View {
        let state = MapState()
        let intent = MapIntent(state: state)
        let container = Container(
            intent: intent as MapIntentProtocol,
            state: state as MapStateProtocol,
            modelChangePublisher: state.objectWillChange
        )
        let view = MapView(container: container)
        return view
    }
}
