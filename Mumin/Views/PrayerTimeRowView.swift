//
//  PrayerTimeRow.swift
//  Mumin
//
//  Created by OS on 4.06.2022.
//

import SwiftUI

struct PrayerTimeRowView: View {
  @Binding var isPresented: Bool
  @Binding var alarmIsOn: Bool

  @Binding var picker: DaysOfWeek
  let timeOfDay: TimesOfDay?
  @ObservedObject var fetchedPrayerTime = FetchPrayerTime()
  @State var alarm = Alarm(
  )

  
    
  var body: some View {
    
    HStack {
      Spacer()
      ZStack {
        Capsule()
          .foregroundColor(Color("MenuButtonColor"))
          .frame(width: 100, height: 30, alignment: .leading)
        Text("\(timeOfDay?.rawValue.uppercased() ?? "morning")")
          .foregroundColor(Color("TextColor"))
          .font(.subheadline)
          .bold()
      }
      ZStack {
        Capsule()
          .foregroundColor(Color("MenuButtonColor"))
          .frame(width: 185, height: 30, alignment: .leading)
        Text("\(fetchedPrayerTime.fetchPrayerTime(time: timeOfDay ?? .morning)?.replacingOccurrences(of: "%", with: "") ??  "")")
          .foregroundColor(Color("TextColor"))
          .font(.headline)
          .bold()
          .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in
            90
          })
        Text("----")
          .foregroundColor(Color("TextColor"))
          .rotationEffect(.degrees(90))
          .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in
            25
          })
//        Button(action: {isPresented.toggle()}, label: { selections.selections.count <= 1 ? Text(selections.selections.first?.rawValue ?? "empty") : Text("Multiple Selection")})
//          .sheet(isPresented: $isPresented, content: {
//            MultipleSelectionView()
//          })
//                  NavigationLink(picker.first?.rawValue ?? "Monday", destination: MultipleSelectionView())
        Picker("\( Text(picker.rawValue).bold())", selection: $picker, content: { ForEach(DaysOfWeek.allCases) { day in
          Text(day.rawValue.uppercased())
            .bold()

        }
        }).pickerStyle(
          .menu)
        .accentColor(Color("TextColor"))
        .font(.headline)
        .alignmentGuide(HorizontalAlignment.center, computeValue: {_ in 3})
      }
      Button(action: {alarmIsOn.toggle();
        var alarm = self.alarm
        if alarmIsOn {
        alarm.setAlarm(weekDay: picker, time: timeOfDay!)
        self.alarm = alarm
        }
        else {
          self.alarm.cancelAlarm()
        }
      }, label: {Image(systemName: "capsule.portrait\(toggleButton() ?? "")")
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

enum DaysOfWeek: String, CaseIterable, Identifiable {
  var id: Self {self}
  
  case sunday
  case monday
  case tuesday
  case wednesday
  case thursday
  case friday
  case saturday
  case everyday
  
  var info: Int {
    switch self {
    case .sunday: return 7
    case .monday: return 1
    case .tuesday: return 2
    case .wednesday: return 3
    case .thursday: return 4
    case .friday: return 5
    case .saturday: return 6
    case .everyday: return 0
    }
  }
}

enum TimesOfDay: String, CaseIterable, Identifiable {
  var id: Self { self }
  
  case morning
  case midday
  case afternoon
  case evening
  case night
}


struct PrayerTimeRow_Previews: PreviewProvider {
    static var previews: some View {
      PrayerTimeRowView(isPresented: .constant(true), alarmIsOn: .constant(true), picker: .constant(.saturday), timeOfDay: .afternoon)
    }
}