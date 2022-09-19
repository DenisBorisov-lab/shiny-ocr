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
      VStack {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundColor(.accentColor)
        Text("Hello, world!")
      }
      .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
