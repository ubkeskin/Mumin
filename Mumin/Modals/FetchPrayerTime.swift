//
//  FetchPrayerTime.swift
//  Mumin
//
//  Created by OS on 23.05.2022.
//

import Foundation
import MapKit

class FetchPrayerTime: NSObject, ObservableObject, URLSessionDelegate {
  var userLocation: UserLocationModal
  var task: URLSessionDataTask?
  var url: URL?
  var urlComponents = URLComponents()
  var dateFormatter = DateFormatter()
  var date = Date().formatted(date: .numeric, time: .omitted)
  
  
  
  @Published var prayerTime: PrayerTimeModal?
  
  override init() {
    userLocation = UserLocationModal()
    super.init()
    fetchDataAtUrl()
    print(userLocation.latitude)
  }
    
  
  lazy var urlSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
  }()
  
  
  func fetchDataAtUrl() {
    let locationAuthorizationStatus = userLocation.locationManager.authorizationStatus
    self.urlComponents.scheme = "https"
    urlComponents.host = "api.aladhan.com"
    dateFormatter.dateFormat = "dd-MM-yyyy"
//    print("/v1/timings/" + "\(dateFormatter.string(from: Date()))")
    urlComponents.path = "/v1/timings/" + "\(Date())"

    urlComponents.queryItems = [
      URLQueryItem(name: "latitude", value: "\(userLocation.latitude.description)"),
      URLQueryItem(name: "longitude", value: "\(userLocation.longitude.description)"),
    URLQueryItem(name: "method", value: "13"),
    URLQueryItem(name: "school", value: "0"),
    URLQueryItem(name: "midnightMode", value: "0")


    ]
    
    var request = URLRequest(url: (urlComponents.url!))
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
//              print(result)
          }
      enum DateError: String, Error {
          case invalidDate
      }
          let decoder = JSONDecoder()
      switch locationAuthorizationStatus {
      case .notDetermined:
        self.userLocation.locationManager.requestWhenInUseAuthorization()
      case .restricted, .denied:
        self.userLocation.locationManager.requestWhenInUseAuthorization()
      case .authorizedAlways, .authorizedWhenInUse, .authorized:
        DispatchQueue.global(qos: .userInitiated).sync {
          do {
            self.prayerTime = try decoder.decode(PrayerTimeModal.self, from: data)
          } catch let error {
            print(error)
          }
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
