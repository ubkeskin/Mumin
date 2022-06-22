//
//  MuminApp.swift
//  Mumin
//
//  Created by OS on 20.03.2022.
//

import SwiftUI
 
@main
struct MuminApp: App {
  var locationManager = UserLocationModal()
  
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
