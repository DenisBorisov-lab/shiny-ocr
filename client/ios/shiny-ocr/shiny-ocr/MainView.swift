//
//  ContentView.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 19.09.2022.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      AddImageView()
        .tabItem {
          Label("Image OCR", systemImage: "camera.metering.partial")
        }
      ProfileView()
        .tabItem {
          Label("Profile", systemImage: "person.fill")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
