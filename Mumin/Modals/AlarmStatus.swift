//
//  AlarmStatus.swift
//  Mumin
//
//  Created by OS on 11.06.2022.
//

import Foundation

class AlarmStatus: ObservableObject, Codable {
  var isOn: Bool = false
  var middayIsOn: Bool = false
  var afternoonIsOn: Bool = false
  var eveningIsOn: Bool = false
  var nightIsOn: Bool = false
}
