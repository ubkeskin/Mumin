//
//  ContentView.swift
//  Mumin
//
//  Created by OS on 20.03.2022.
//

import SwiftUI


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
  let alarm: Alarm
    
    var body: some View {
//      if userLocation.status == .authorizedWhenInUse || userLocation.status == .authorizedAlways {
        
        ZStack {
          Color("BackgroundColor")
            .ignoresSafeArea()
          VStack {
            ClockView()
            Spacer()
            Divider()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.isOn, picker: $picker, alarm: alarm, timeOfDay: .morning, fetchedPrayerTime: fetchedPrayerTime)
              .padding()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.middayIsOn, picker: $middayPicker, alarm: alarm, timeOfDay: .midday, fetchedPrayerTime: fetchedPrayerTime)
              .padding()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.eveningIsOn, picker: $afternoonPicker, alarm: alarm, timeOfDay: .afternoon, fetchedPrayerTime: fetchedPrayerTime)
              .padding()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.afternoonIsOn, picker: $eveningPicker, alarm: alarm, timeOfDay: .evening, fetchedPrayerTime: fetchedPrayerTime)
              .padding()
            PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $alarmStore.alarmStatus.nightIsOn, picker: $nightPicker, alarm: alarm, timeOfDay: .night, fetchedPrayerTime: fetchedPrayerTime)
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
      ContentView(fetchedPrayerTime: FetchPrayerTime(), alarm: Alarm(fetchedPrayerTime: FetchPrayerTime()))
      ContentView(fetchedPrayerTime: FetchPrayerTime(), alarm: Alarm(fetchedPrayerTime: FetchPrayerTime()))
        .preferredColorScheme(.dark)
    }
}
