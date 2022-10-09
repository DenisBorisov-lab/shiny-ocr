//
//  ScannerManager.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 08.10.2022.
//

import Foundation

protocol ScannerManagerDelegate: AnyObject {
  func scannerManager(_ manager: ScannerManager, didReceiveScan: RecivedScan)
}

class ScannerManager {
  private let socket = SocketIO(url: URL(string: "ws://localhost:8081")!)
  weak var delegate: ScannerManagerDelegate?
  var isConnected = false
  
  func connectToTesseractServer() {
    socket.delegate = self
//    socket.connect()
  }
    
  func scan(_ scan: SendingScan) {
    print("Sending: \(scan)")
  }
}

extension ScannerManager: SocketIODelegate {
  func receiveData(_ data: Data) {
    //
  }
}
