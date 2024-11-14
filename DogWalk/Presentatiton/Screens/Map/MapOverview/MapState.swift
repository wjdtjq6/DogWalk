//
//  MapState.swift
//  DogWalk
//
//  Created by 소정섭 on 11/12/24.
//

import Foundation
import SwiftUI
import MapKit
import Combine

//MARK: 데이터 관련 프로토콜
protocol MapStateProtocol { // 속성들을 가지는 프로토콜
    var isShowingSheet: Bool { get }
    //Timer
    var count: Int { get }
    var timer: Publishers.Autoconnect<Timer.TimerPublisher> { get }
    var isTimerOn: Bool { get }
    var isAlert: Bool { get }
    //현위치
    var locationManager: LocationManager { get }
    var position: MapCameraPosition { get }
    var polylineColor: Color { get }
}

protocol MapActionProtocol: AnyObject { // 메서드을 가지고있는 프로토콜
    func setTimerOn(_ isOn: Bool)
    func resetCount()
    func incrementCount()
    func startLocationTracking()
    func stopLocationTracking()
    func setAlert(_ isOn: Bool)
}
//MARK: - view에 전달할 데이터
@Observable
final class MapState: MapStateProtocol, ObservableObject {
    var isShowingSheet: Bool = false
    //Timer
    var count: Int = 0
    var timer: Publishers.Autoconnect<Timer.TimerPublisher> {
        return Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    var isTimerOn : Bool = false
    var isAlert: Bool = false
    //현위치
    var locationManager = LocationManager()
    var position: MapCameraPosition = .userLocation(fallback: .automatic)
    var polylineColor = Color(
        red: Double.random(in: 0...1),
        green: Double.random(in: 0...1),
        blue: Double.random(in: 0...1)
    )
}

// MARK: - intent에 줄 함수
extension MapState: MapActionProtocol {
    func setTimerOn(_ isOn: Bool) {
        isTimerOn = isOn
    }
    
    func resetCount() {
        count = 0
    }
    
    func incrementCount() {
        count += 1800
    }
    
    func startLocationTracking() {
        locationManager.isTrackingPath = true
        locationManager.resetLocations()
    }
    
    func stopLocationTracking() {
        locationManager.isTrackingPath = false
    }
    
    func setAlert(_ isOn: Bool) {
        isAlert = isOn
    }
}
