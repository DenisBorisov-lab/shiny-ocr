//
//  SendingScan.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 02.10.2022.
//

import Foundation

// ws://192.168.1.2:8080/scanner-server

struct SendingScan: Encodable {
  let language: OCRLanguage
  let format: String
  let image: Data
  let userId: UUID
}

enum OCRLanguage: String, CaseIterable, Encodable {
  case rus, eng
  
  var introduction: String {
    switch self {
    case .rus:
      return "Русский"
    case .eng:
      return "Английский"
    }
  }
}
