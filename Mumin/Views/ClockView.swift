//
//  ClockView.swift
//  Mumin
//
//  Created by OS on 20.03.2022.
//


import SwiftUI
import Foundation

struct ClockView: View {
  var minutes = MinuteHand()
  var hours = HourHand()
  
  var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
              ZStack {
                    Circle()
                        .frame(width: 250.0, height: 250.0)
                        .foregroundColor(Color("MenuButtonColor"))
                minutes
                hours
              }
          
        }
  }
}

class Time: NSObject, ObservableObject {
  @objc var date = Date()
  var calendar = Calendar(identifier: .gregorian)
  var hour: Int {
    calendar.component(.hour, from: date)
  }
  var minutes: Int {
    calendar.component(.minute, from: date)
  }
}

struct MinuteHand: View {
  @State var time = Time()
  var rotation: Int
  { 270 + time.minutes * 6  }
  var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

  
  var body: some View {
    Rectangle()
      .foregroundColor(Color("TextColor"))
      .frame(width: 130, height: 5)
      .cornerRadius(10)
      .offset(x: 50, y: 0)
      .rotationEffect(Angle(degrees: Double(rotation)))
      .animation(.linear, value: time.minutes)
      .onReceive(timer) { _ in
        self.time = Time()
      }
      
  }
}
struct HourHand: View {
  @State var time = Time()
  var rotation: Int
  { 270 + time.hour * 15  }
  var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
  

  var body: some View {
    Rectangle()
      .foregroundColor(Color("TextColor"))
      .frame(width: 100, height: 5)
      .cornerRadius(10)
      .offset(x: 30, y: 0)
      .rotationEffect(Angle(degrees: Double(rotation)))
      .animation(.linear, value: rotation)
      .onReceive(timer) { _ in
        self.time = Time()
      }
  }
}


struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
      ClockView()
        .preferredColorScheme(.light)
      ClockView()
        .preferredColorScheme(.dark)
    }
}

