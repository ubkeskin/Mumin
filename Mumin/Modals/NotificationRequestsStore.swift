//
//  NotificationRequestsStore.swift
//  Mumin
//
//  Created by OS on 16.06.2022.
//

import Foundation
import SwiftUI
import Combine

class NotificationRequestsStore: ObservableObject {
  @Published var requests = NotificationRequests() {
    didSet {
      saveNotificationRequest()
    }
  }
    
  init() {
    loadRequestsJSON()
  }
  
  func loadRequestsJSON() {
    let decoder = JSONDecoder()
    let requestsURL = Bundle.main.url(forResource: "NotificationRequests", withExtension: "json")
    
    do {
      let requestsData = try Data(contentsOf: requestsURL!)
      let requests = try decoder.decode(NotificationRequests.self, from: requestsData)
      self.requests = requests
    } catch let error {
      print(error)
    }
  }
  
  func saveNotificationRequest() {
    let encoder = JSONEncoder()
    let requestsURL = Bundle.main.url(forResource: "NotificationRequests", withExtension: "json")

    do {
      let saveData = try encoder.encode(requests)
      try saveData.write(to: requestsURL!)
      print(requests.requests)
      
    } catch let error {
      print(error)
    }
  }

}
