//
//  HistoryView.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 19.09.2022.
//

import SwiftUI

struct HistoryView: View {
  @State var logs: [Scan] = Scan.mock()
  
  var body: some View {
      List {
        ForEach(logs, id: \.id) { log in
          VStack(alignment: .leading) {
            Text(log.stingTitle)
              .bold()
            Text(log.stringContent)
          }
          .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        }
      }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    HistoryView()
  }
}
