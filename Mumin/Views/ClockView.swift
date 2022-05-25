//
//  ClockView.swift
//  Mumin
//
//  Created by OS on 20.03.2022.
//


import SwiftUI
struct ClockView: View {
  @State var isPresented: Bool = false
  @State var morningPicker: [DaysOfWeek] = [.monday]
  @State var middayPicker: [DaysOfWeek] = [.monday]
  @State var afternoonPicker: [DaysOfWeek] = [.monday]
  @State var eveningPicker: [DaysOfWeek] = [.monday]
  @State var nightPicker: [DaysOfWeek] = [.monday]
  
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
                ZStack {
                    Circle()
                        .frame(width: 250.0, height: 250.0)
                        .foregroundColor(Color("MenuButtonColor")
                                            )
                  MinuteHand()
                  HourHand()
                                    
                }
              Spacer()
              Divider()
              PrayerTimeRow(isPresented: $isPresented, alarmIsOn: $isOn, picker: $morningPicker, timeOfDay: .morning)
                .padding()
              PrayerTimeRow(isPresented: $isPresented, alarmIsOn: $middayIsOn, picker: $middayPicker, timeOfDay: .midday)
                .padding()
              PrayerTimeRow(isPresented: $isPresented, alarmIsOn: $afternoonIsOn, picker: $afternoonPicker, timeOfDay: .afternoon)
                .padding()
              PrayerTimeRow(isPresented: $isPresented, alarmIsOn: $eveningIsOn, picker: $eveningPicker, timeOfDay: .evening)
                .padding()
              PrayerTimeRow(isPresented: $isPresented, alarmIsOn: $nightIsOn, picker: $nightPicker, timeOfDay: .night)
                .padding()
              
              Spacer()
            }
            
        }
  }

}
enum DaysOfWeek: String, CaseIterable, Identifiable {
  var id: Self {self}
  
  case sunday = "sunday"
  case monday = "monday"
  case tuesday = "tuesday"
  case wednesday = "wednesday"
  case thursday = "thursday"
  case friday = "friday"
  case saturday = "saturday"
  case everyday = "everyday"
}

enum TimesOfDay: String, CaseIterable, Identifiable {
  var id: Self { self }
  
  case morning
  case midday
  case afternoon
  case evening
  case night
}

struct MinuteHand: View {
  var body: some View {
    Rectangle()
      .foregroundColor(Color(.white))
      .frame(width: 130, height: 5)
      .cornerRadius(10)
      .offset(x: 50, y: 0)
      .rotationEffect(.degrees(90))
  }
}
struct HourHand: View {
  var body: some View {
    Rectangle()
      .foregroundColor(Color(.white))
      .frame(width: 100, height: 5)
      .cornerRadius(10)
      .offset(x: 30, y: 0)
      .rotationEffect(.degrees(0))
  }
}

struct PrayerTimeRow: View {
  @Binding var isPresented: Bool
  @Binding var alarmIsOn: Bool
  @Binding var picker: [DaysOfWeek]
  @ObservedObject var selections = Selections()
  let timeOfDay: TimesOfDay?
  @ ObservedObject var fetchedPrayerTime = FetchPrayerTime()
    
  var body: some View {
    
    HStack {
      Spacer()
      ZStack {
        Capsule()
          .foregroundColor(Color("MenuButtonColor"))
          .frame(width: 100, height: 30, alignment: .leading)
        Text("\(timeOfDay?.rawValue.uppercased() ?? "morning")")
          .foregroundColor(.white)
          .font(.subheadline)
          .bold()
      }
      ZStack {
        Capsule()
          .foregroundColor(Color("MenuButtonColor"))
          .frame(width: 185, height: 30, alignment: .leading)
        Text("\(fetchedPrayerTime.fetchPrayerTime(time: timeOfDay ?? .morning)?.replacingOccurrences(of: "%", with: "") ??  "")")
          .foregroundColor(.white)
          .font(.headline)
          .bold()
          .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in
            90
          })
        Text("----")
          .foregroundColor(.white)
          .rotationEffect(.degrees(90))
          .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in
            25
          })
//        Button(action: {isPresented.toggle()}, label: { selections.selections.count <= 1 ? Text(selections.selections.first?.rawValue ?? "empty") : Text("Multiple Selection")})
//          .sheet(isPresented: $isPresented, content: {
//            MultipleSelectionView()
//          })
                  NavigationLink(picker.first?.rawValue ?? "Monday", destination: MultipleSelectionView())
                Picker("\(picker.count == 1 ? Text(picker.first!.rawValue).bold() : Text("Multiple"))", selection: $picker, content: { ForEach(DaysOfWeek.allCases) { day in
          Text(day.rawValue.uppercased())
            .bold()

        }
        }).pickerStyle(
          .menu)
        .colorMultiply(.black)
        .colorInvert()
        .font(.headline)
        .alignmentGuide(HorizontalAlignment.center, computeValue: {_ in 3})
      }
      Button(action: {alarmIsOn.toggle()}, label: {Image(systemName: "capsule.portrait\(toggleButton() ?? "")")
          .resizable()
          .frame(width: 20, height: 30)
          .foregroundColor(Color("MenuButtonColor"))
      })
      
      Spacer()
    }.onAppear(){
      fetchedPrayerTime.fetchDataAtUrl()
    }
  }
  func toggleButton() -> String? {
    alarmIsOn == true ? ".fill" : nil
  }
  
//  func dayPicker() -> [DaysOfWeek] {
//
//  }
  }

struct OtherView: View {
  var body: some View {
    ClockView()
  }
}


struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
      OtherView()
    }
}

