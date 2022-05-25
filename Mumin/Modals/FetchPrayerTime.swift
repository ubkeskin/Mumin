//
//  FetchPrayerTime.swift
//  Mumin
//
//  Created by OS on 23.05.2022.
//

import Foundation
import MapKit

class FetchPrayerTime: NSObject, ObservableObject, URLSessionDelegate {
  var task: URLSessionDataTask?
  var url: URL?
  
  @Published var prayerTime: PrayerTimeModal?
    
  
  lazy var urlSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
  }()
  
    
  func fetchDataAtUrl() {
    self.url = URL(string: "https://api.aladhan.com/v1/timings/" + "\(NSDate.now.formatted(date: .numeric, time: .omitted))".replacingOccurrences(of: "/", with: "-") + "?latitude=38.19612&longitude=26.83971&method=13&school=1")
    
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    
    task = urlSession.dataTask(with: request) { data, response, error in
          guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
              return
          }
          guard let data = data else {
              return
          }
          if let result = String(data: data, encoding: .utf8) {
              print(result)
          }
      enum DateError: String, Error {
          case invalidDate
      }
          let decoder = JSONDecoder()
      DispatchQueue.main.async {
        do {
          self.prayerTime = try decoder.decode(PrayerTimeModal.self, from: data)
        } catch let error {
          print(error)
        }
      }
    }
    task?.resume()
    
    
  }
  func fetchPrayerTime(time: TimesOfDay) -> String? {
    switch time {
    case .morning: return prayerTime?.data?.timings.Sunrise
    case .midday: return prayerTime?.data?.timings.Dhuhr
    case .afternoon: return prayerTime?.data?.timings.Asr
    case .evening: return prayerTime?.data?.timings.Sunset
    case .night: return prayerTime?.data?.timings.Isha
    }
  }
  
}
