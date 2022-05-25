//
//  PrayersTimeModal.swift
//  Mumin
//
//  Created by OS on 23.05.2022.
//

import Foundation
import MapKit

struct PrayersTimeModal: Codable, Identifiable {
  let id: Int
  let date: String
  let latitude: Float
  let longitude: Float
  let method: Int
  let shafaq: String
  let tune: String
  let school: Int
  let midnightMode: Int
  let timezoneString: String
  let latitudeAdjustmentMethod: Int
  let adjustment: Int
  let iso8601: Bool
  
  enum CodingKeys: String, CodingKey {
    case id = "timeId"
    case date
    case latitude
    case longitude
    case method
    case shafaq
    case tune
    case school
    case midnightMode
    case timezoneString
    case latitudeAdjustmentMethod
    case adjustment
    case iso8601
  }
  
  init(id: Int, date: String, latitude: Float, longitude: Float, method: Int, shafaq: String, tune: String, school: Int, midnightMode: Int, timezoneString: String, latitudeAdjustmentMethod: Int, adjustment: Int, iso8601: Bool) {
    self.id = id
    self.date = date
    self.latitude = latitude
    self.longitude = longitude
    self.method = method
    self.shafaq = shafaq
    self.tune = tune
    self.school = school
    self.midnightMode = midnightMode
    self.timezoneString = timezoneString
    self.latitudeAdjustmentMethod = latitudeAdjustmentMethod
    self.adjustment = adjustment
    self.iso8601 = iso8601
  }
}
