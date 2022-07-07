//
//  Alarm.swift
//  Mumin
//
//  Created by OS on 1.06.2022.
//

import Foundation
import SwiftUI
import AudioToolbox
import Combine

class Alarm: Equatable, ObservableObject {

  lazy var uuidString = UUID().uuidString
  let notification = UNUserNotificationCenter.current()
  var calendar = Calendar(identifier: .gregorian)
  let sound = UNNotificationSound(named: UNNotificationSoundName.init(rawValue: "adhan.wav"))
    
  
  var dateComponents = DateComponents()
  @ObservedObject var fetchedPrayerTime: FetchPrayerTime

  @Published var requests = NotificationRequests()
  
  
  init(fetchedPrayerTime: FetchPrayerTime) {
    self.fetchedPrayerTime = fetchedPrayerTime
    calendar.locale = .init(identifier: "tr_TR")
    loadNotificationRequests()
  }
  
  static func == (lhs: Alarm, rhs: Alarm) -> Bool {
    lhs.requests.requests == rhs.requests.requests
  }

//  mutating func loadNotificationRequests() {
//    let decoder = JSONDecoder()
//    let requestsURL = Bundle.main.url(forResource: "NotificationRequests", withExtension: "json")
//
//    do {
//      let requestsData = try Data(contentsOf: requestsURL!)
//      self.requests = try decoder.decode(NotificationRequests.self, from: requestsData)
//      print(requests.requests)
//    } catch let error {
//      print(error)
//    }
//  }
  
  func loadNotificationRequests() {
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
//      print(requests.requests)
      print(saveData)
      
    } catch let error {
      print(error)
    }
  }
  
  func setAlarm(weekDay: DaysOfWeek, time: TimesOfDay) {
    dateComponents.calendar = calendar
    dateComponents.year = Int((fetchedPrayerTime.prayerTime?.data?.date.gregorian.year)!)
    dateComponents.month = (fetchedPrayerTime.prayerTime?.data?.date.gregorian.month.number)
    dateComponents.day = Int((fetchedPrayerTime.prayerTime?.data?.date.gregorian.day)!)

    dateComponents.hour = Int((fetchedPrayerTime.fetchPrayerTime(time: time)?.dropLast(3)).map{$0}!)
    dateComponents.minute = Int(((fetchedPrayerTime.fetchPrayerTime(time: time)?.dropFirst(3))!))
    print(dateComponents.isValidDate)
    
    let notificationContent = UNMutableNotificationContent()
    notificationContent.title = "It is pray time!"
    notificationContent.sound = sound
    notificationContent.body = "\(time) pray"
    if fetchedPrayerTime.prayerTime?.data?.date.gregorian.weekday.en.lowercased() == weekDay.rawValue && dateComponents.hour! >= Int(Date.now.formatted(date: .omitted, time: .shortened).dropLast(3))! {
      dateComponents.day = Int((dateComponents.date?.addingTimeInterval(60*60*24*7).formatted(date: .numeric, time: .omitted).dropLast(8))!)
      if dateComponents.month! != Int((dateComponents.date?.addingTimeInterval(60*60*24*7).formatted(date: .numeric, time: .omitted).substring(from: ".", to: "."))!) {
        dateComponents.month! += 1
      }
      if dateComponents.year! != Int((dateComponents.date?.addingTimeInterval(60*60*24*7).formatted(date: .numeric, time: .omitted).dropFirst(6))!) {
        dateComponents.year! += 1
      }
    }
      notification.requestAuthorization(options: [.alert,.sound]) { [self]
          (granted, error) in
          if granted {
       print("granted")
          } else {
       print("denied or error")
          }
      }
      let alarmTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
      let request = UNNotificationRequest(identifier: uuidString, content: notificationContent, trigger: alarmTrigger)
      notification.add(request)
    
    requests.requests["\(time.rawValue)\(weekDay.rawValue)"] = uuidString
    saveNotificationRequest()
  }
  func cancelAlarm(weekDay: DaysOfWeek, time: TimesOfDay) {
    print(requests.requests.keys)
    notification.removePendingNotificationRequests(withIdentifiers: [loadRequests(weekDay: weekDay, time: time)])
    requests.requests.removeValue(forKey: "\(time.rawValue)\(weekDay.rawValue)")
    saveNotificationRequest()
  }
  func loadRequests(weekDay: DaysOfWeek, time: TimesOfDay) -> String {
    guard let request = requests.requests["\(time.rawValue)\(weekDay.rawValue)"] else {
      fatalError()
    }
    return request
  }
}
