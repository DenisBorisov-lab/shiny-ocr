//
//  SendingScan.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 02.10.2022.
//

import Foundation

// ws://192.168.1.2:8080/scanner-server

struct SendingScan: Encodable {
  let language: Language
  let format: String
  let image: Data
  let userId: UUID
}

enum Language: String, CaseIterable, Encodable {
  case rus, eng
}
