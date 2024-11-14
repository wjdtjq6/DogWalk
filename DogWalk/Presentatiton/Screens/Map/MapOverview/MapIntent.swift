//
//  MapIntent.swift
//  DogWalk
//
//  Created by 소정섭 on 11/12/24.
//

import Foundation

protocol MapIntentProtocol {
    func startWalk()
    func stopWalk()
    func incrementTimer()
    func showAlert()
    func closeAlert()
}

final class MapIntent {
    private weak var state: MapActionProtocol?
    
    init(state: MapActionProtocol? = nil) {
        self.state = state
    }
}

extension MapIntent: MapIntentProtocol {
    func startWalk() {
        print(#function)
        state?.resetCount()
        state?.setTimerOn(true)
        state?.startLocationTracking()
    }
    
    func stopWalk() {
        print(#function)
        state?.setTimerOn(false)
        state?.stopLocationTracking()
    }
    
    func incrementTimer() {
        state?.incrementCount()
    }
    
    func showAlert() {
        state?.setAlert(true)
    }
    
    func closeAlert() {
        state?.setAlert(false)
    }
}
