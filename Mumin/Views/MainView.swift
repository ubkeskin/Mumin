//
//  MainView.swift
//  Mumin
//
//  Created by OS on 30.06.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var userLocation = UserLocationModal()
    @StateObject var fetchedPrayerTime = FetchPrayerTime()

  var body: some View {
if userLocation.status == .authorizedWhenInUse || userLocation.status == .authorizedAlways {
  ContentView(fetchedPrayerTime: fetchedPrayerTime, alarm: Alarm(fetchedPrayerTime: fetchedPrayerTime))
}
  }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
