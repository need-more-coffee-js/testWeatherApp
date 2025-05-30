//
//  LocationManager.swift
//  weather
//
//  Created by Денис Ефименков on 21.05.2025.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var onLocationReceived: ((CLLocationCoordinate2D) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func requestLocation() {
            let status = manager.authorizationStatus
            if status == .denied || status == .restricted {
                let moscow = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)
                onLocationReceived?(moscow)
            } else {
                manager.requestWhenInUseAuthorization()
            }
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
                manager.startUpdatingLocation()
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        onLocationReceived?(location.coordinate)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)
        // Используем Москву как fallback
        let moscow = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)
        onLocationReceived?(moscow)
    }
}
