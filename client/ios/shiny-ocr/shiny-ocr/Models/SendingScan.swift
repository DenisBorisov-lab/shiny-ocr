//
//  SendingScan.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 02.10.2022.
//

import Foundation

struct SendingScan: Encodable {
  let format: String
  let image: Data
  let userId: UUID
}
