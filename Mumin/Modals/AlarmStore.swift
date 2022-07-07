//
//  AlarmStore.swift
//  Mumin
//
//  Created by OS on 11.06.2022.
//

import Foundation
import Combine

class AlarmStore: ObservableObject {
   @Published var alarmStatus = AlarmStatus() {
    didSet {
      saveAlarmStatusJSON()
    }
  }  
  let alarmStatusUrl = Bundle.main.url(forResource: "AlarmStatus", withExtension: "json")
  
  init() {
    loadAlarmStatusJSON()
  }
  
  func loadAlarmStatusJSON() {
    let decoder = JSONDecoder()
    
    do {
      let alarmStatusData = try Data(contentsOf: alarmStatusUrl!)
      alarmStatus = try decoder.decode(AlarmStatus.self, from: alarmStatusData)
    } catch let error {
      print(error)
    }
  }
  
  func saveAlarmStatusJSON() {
    let encoder = JSONEncoder()
    
    do {
      let saveData = try encoder.encode(alarmStatus)
      try saveData.write(to: alarmStatusUrl!)
      
    } catch let error {
      print(error)
    }
  }
}
