//
//  ContentView.swift
//  Mumin
//
//  Created by OS on 20.03.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var userLocation = UserLocationModal()
    @StateObject var fetchedPrayerTime = FetchPrayerTime()

  var body: some View {
if userLocation.status == .authorizedWhenInUse || userLocation.status == .authorizedAlways {
  ContentView(fetchedPrayerTime: fetchedPrayerTime)
}
  }
}

struct ContentView: View {
  @State var isPresented: Bool = false
  @State var picker: DaysOfWeek = .tuesday
  @State var middayPicker: DaysOfWeek = .monday
  @State var afternoonPicker: DaysOfWeek = .monday
  @State var eveningPicker: DaysOfWeek = .monday
  @State var nightPicker: DaysOfWeek = .monday
  
//  @StateObject var userLocation = UserLocationModal()
  
  @ObservedObject var alarmStore = AlarmStore()
  @ObservedObject var fetchedPrayerTime: FetchPrayerTime
    
    var body: some View {
//      if userLocation.status == .authorizedWhenInUse || userLocation.status == .authorizedAlways {
        
        ZStack {
          Color("BackgroundColor")
            .ignoresSafeArea()
          VStack {
            ClockView()
            Spacer()
            Divider()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.isOn, picker: $picker, alarm: alarmStore.alarm, timeOfDay: .morning, fetchedPrayerTime: fetchedPrayerTime)
              .padding()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.middayIsOn, picker: $middayPicker, alarm: alarmStore.alarm, timeOfDay: .midday, fetchedPrayerTime: fetchedPrayerTime)
              .padding()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.eveningIsOn, picker: $afternoonPicker, alarm: alarmStore.alarm, timeOfDay: .afternoon, fetchedPrayerTime: fetchedPrayerTime)
              .padding()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.afternoonIsOn, picker: $eveningPicker, alarm: alarmStore.alarm, timeOfDay: .evening, fetchedPrayerTime: fetchedPrayerTime)
              .padding()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.nightIsOn, picker: $nightPicker, alarm: alarmStore.alarm, timeOfDay: .night, fetchedPrayerTime: fetchedPrayerTime)
              .padding()
            Menu {
              
            } label: {
              Image("MenuButtonImage")
                .resizable()
                .frame(width: 100, height: 80)
            }
            
            Spacer()
          }
          }
        }
      }
//    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(fetchedPrayerTime: FetchPrayerTime())
      ContentView(fetchedPrayerTime: FetchPrayerTime())
        .preferredColorScheme(.dark)
    }
}
