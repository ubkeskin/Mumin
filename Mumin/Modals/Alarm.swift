//
//  Alarm.swift
//  Mumin
//
//  Created by OS on 1.06.2022.
//

import Foundation
import SwiftUI
import AudioToolbox

struct Alarm {
  let uuidString = UUID().uuidString
  let notification = UNUserNotificationCenter.current()
  var calendar = Calendar(identifier: .gregorian)
  let sound = UNNotificationSound(named: UNNotificationSoundName.init(rawValue: "adhan.wav"))
    
  
  var dateComponents = DateComponents()
  @ObservedObject var fetchedPrayerTime = FetchPrayerTime()
  var requests: [UNNotificationRequest] = []
  
  
  init() {
    fetchedPrayerTime.fetchDataAtUrl()
    calendar.locale = .init(identifier: "tr_TR")
  }
  
  mutating func setAlarm(weekDay: DaysOfWeek, time: TimesOfDay) {
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
    
    self.requests.append(request)
  }
  mutating func cancelAlarm() {
    notification.removePendingNotificationRequests(withIdentifiers: [uuidString])
    requests.remove(at: 0)
  }
}
