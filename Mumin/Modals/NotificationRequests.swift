//
//  NotificationRequests.swift
//  Mumin
//
//  Created by OS on 14.06.2022.
//

import Foundation
import SwiftUI
import Combine


class NotificationRequests: Codable, ObservableObject, Equatable {
  static func == (lhs: NotificationRequests, rhs: NotificationRequests) -> Bool {
    lhs.requests == rhs.requests
  }
  
  var requests: [String:String] = [:]

}
