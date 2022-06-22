//
//  UserLocationModal.swift
//  Mumin
//
//  Created by OS on 20.06.2022.
//

import Foundation
import SwiftUI
import CoreLocation

class UserLocationModal: NSObject, ObservableObject, CLLocationManagerDelegate {
  let locationManager = CLLocationManager()
  var userLocation: CLLocation {
    locationManager.location  ?? CLLocation(latitude: 0, longitude: 0)
  }
  var longitude: CLLocationDegrees {
    userLocation.coordinate.longitude
  }
  var latitude: CLLocationDegrees {
    userLocation.coordinate.latitude
  }
  @Published var status: CLAuthorizationStatus?
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    self.status = self.locationManager.authorizationStatus
    DispatchQueue.global(qos: .default).async {
      self.locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    status = manager.authorizationStatus
  }
}
