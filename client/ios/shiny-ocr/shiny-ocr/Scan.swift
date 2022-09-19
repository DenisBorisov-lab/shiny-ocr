//
//  Scan.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 19.09.2022.
//

import Foundation

struct Scan {
  let id = UUID().uuidString
  let stingTitle: String
  let stringContent: String
}

extension Scan {
  static func mock() -> [Self] {
    [
    Scan(stingTitle: "Scan Aboba", stringContent: "ijkloadfrswadfswijkloadfsijkloadfsijkloadfsjkljkladfsjkladfsjkl"),
    Scan(stingTitle: "Scan Aboba", stringContent: "ijkloadfrswadfswijkloadfsijkloadfsijkloadfsjkljkladfsjkladfsjkl"),
    Scan(stingTitle: "Scan Aboba", stringContent: "ijkloadfrswadfswijkloadfsijkloadfsijkloadfsjkljkladfsjkladfsjkl"),
    Scan(stingTitle: "Scan Aboba", stringContent: "ijkloadfrswadfswijkloadfsijkloadfsijkloadfsjkljkladfsjkladfsjkl"),
    Scan(stingTitle: "Scan Aboba", stringContent: "ijkloadfrswadfswijkloadfsijkloadfsijkloadfsjkljkladfsjkladfsjkl"),
    Scan(stingTitle: "Scan Aboba", stringContent: "ijkloadfrswadfswijkloadfsijkloadfsijkloadfsjkljkladfsjkladfsjkl"),
    ]
  }
}
