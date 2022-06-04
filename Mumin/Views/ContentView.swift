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
  
  @State var isOn: Bool = false
  @State var middayIsOn: Bool = false
  @State var afternoonIsOn: Bool = false
  @State var eveningIsOn: Bool = false
  @State var nightIsOn: Bool = false
  @State var alarmIsOn: Bool = false
    
    var body: some View {
      ZStack {
          Color("BackgroundColor")
              .ignoresSafeArea()
        VStack {
          ClockView()
          Spacer()
          Divider()
          PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $isOn, picker: $picker, timeOfDay: .morning)
            .padding()
          PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $middayIsOn, picker: $middayPicker, timeOfDay: .midday)
            .padding()
          PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $afternoonIsOn, picker: $afternoonPicker, timeOfDay: .afternoon)
            .padding()
          PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $eveningIsOn, picker: $eveningPicker, timeOfDay: .evening)
            .padding()
          PrayerTimeRowView(isPresented: $isPresented, alarmIsOn: $nightIsOn, picker: $nightPicker, timeOfDay: .night)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
        .preferredColorScheme(.dark)
    }
}
