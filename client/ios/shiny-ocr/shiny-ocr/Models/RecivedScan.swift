//
//  RecivedScan.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 20.09.2022.
//

import Foundation

struct RecivedScan: Decodable {
  let id: Int
  let scanText: String
  let scanDate: Date
}

extension RecivedScan {
  static func mock() -> [Self] {
    [
      .init(id: 1233, scanText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu faucibus nibh. In volutpat tellus nec est imperdiet, at venenatis justo commodo. Integer sed turpis ac quam laoreet rutrum. In hac habitasse platea dictumst. Quisque ultricies vitae purus sed auctor. Suspendisse nunc tortor, cursus id purus at, dictum volutpat ipsum. Nunc diam purus, pretium id congue vitae, tempus dictum ante.", scanDate: Date()),
      .init(id: 551, scanText: "SomeScanText", scanDate: Date()),
      .init(id: 4921, scanText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu faucibus nibh.", scanDate: Date())
    ]
  }
}

