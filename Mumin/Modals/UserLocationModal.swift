//
//  UserLocationModal.swift
//  Mumin
//
//  Created by OS on 20.06.2022.
//

import Foundation
import SwiftUI
import CoreLocation

class UserLocationModal {
  let locationManager = CLLocationManager()
  var delegate: CLLocationManagerDelegate {
    locationManager.delegate!.`self`()
  }
  var userLocation: CLLocation {
    locationManager.location  ?? CLLocation(latitude: 0, longitude: 0)
  }
  var longitude: CLLocationDegrees {
    userLocation.coordinate.longitude
  }
  var latitude: CLLocationDegrees {
    userLocation.coordinate.latitude
  }
  var status: CLAuthorizationStatus {
    locationManager.authorizationStatus
  }
  init() {
    DispatchQueue.global(qos: .default).async {
      self.locationManager.requestWhenInUseAuthorization()
    }
  }
}
