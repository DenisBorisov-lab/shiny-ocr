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
      NavigationView {
        AddImageView()
          .navigationTitle("Shiny OCR")
      }
      .tabItem {
        Label("Image OCR", systemImage: "camera.metering.partial")
      }
      NavigationView {
        HistoryView()
          .navigationTitle("History")
      }
      .tabItem {
        Label("History", systemImage: "text.book.closed")
      }
    }
  }
}

//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    MainView()
//  }
//}
