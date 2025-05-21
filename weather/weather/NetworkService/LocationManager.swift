//
//  LocationManager.swift
//  weather
//
//  Created by Денис Ефименков on 21.05.2025.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    static let shared = LocationManager()
    
    var onAuthorizationDenied: (() -> Void)?
    var onLocationReceived: ((CLLocationCoordinate2D) -> Void)?
    private var currentLocation: CLLocationCoordinate2D?
    private var didRequestAuthorization = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation() {
        print("Starting location request...")
        
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Authorization status: notDetermined - requesting access")
            didRequestAuthorization = true
            manager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            print("Authorization status: denied/restricted")
            provideFallbackLocation()
            onAuthorizationDenied?()
            
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authorization status: authorized - requesting location")
            manager.requestLocation()
            
        @unknown default:
            print("Unknown authorization status")
            provideFallbackLocation()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Authorization status changed to: \(manager.authorizationStatus.rawValue)")
        
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if didRequestAuthorization {
                didRequestAuthorization = false
                manager.requestLocation()
            }
            
        case .denied, .restricted:
            provideFallbackLocation()
            onAuthorizationDenied?()
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("Received empty locations array")
            provideFallbackLocation()
            return
        }
        
        print("Successfully received location: \(location.coordinate)")
        currentLocation = location.coordinate
        onLocationReceived?(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
        provideFallbackLocation()
    }
    
    // MARK: - Private Helpers
    
    private func provideFallbackLocation() {
        let moscowLocation = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)
        print("Providing fallback location: \(moscowLocation)")
        currentLocation = moscowLocation
        onLocationReceived?(moscowLocation)
    }
}
