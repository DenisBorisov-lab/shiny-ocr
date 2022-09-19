//
//  AddImageView.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 19.09.2022.
//

import SwiftUI

struct AddImageView: View {
  @State private var settings = [
    "OCR Language",
    "Other Settings"
  ]
  @State private var inputSource = [
    "Image From Camera",
    "Image From Media"
  ]

  var body: some View {
    List {
      Section {
        ForEach(settings, id: \.self) { row in
          Text(row)
        }
      }
      Section {
        ForEach(inputSource, id: \.self) { row in
          Text(row)
        }
      }
    }
  }
}
