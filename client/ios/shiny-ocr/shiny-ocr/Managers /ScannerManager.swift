//
//  ScannerManager.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 08.10.2022.
//

import Foundation

protocol ScannerManagerDelegate: AnyObject {
  func lockScanActions()
  func unlockScanActions()
  func scannerManager(_ manager: ScannerManager, didReceiveScan: RecivedScan)
}

class ScannerManager {
  private let webSocket: WebSocketProvider = NativeWebSocket(url: URL(string: "ws://localhost:8080/scanner-server")!)
  weak var delegate: ScannerManagerDelegate?
    
  init() {
    webSocket.connect()
  }
    
  func scan(_ scan: SendingScan) {
    webSocket.send(Data())
  }
}

extension ScannerManager: WebSocketDelegate {
  func webSocketDidConnect() {
    delegate?.unlockScanActions()
  }
    
  func webSocketDidDisconnect() {
    delegate?.lockScanActions()
  }
    
  func webSocket(didReceiveString string: String) {
    print("WARN: web socket reveice string! Expected")
  }
    
  func webSocket(didReceiveData data: Data) {
    guard let receivedScan = try? JSONDecoder().decode(RecivedScan.self, from: data) else { return }
    delegate?.scannerManager(self, didReceiveScan: receivedScan)
  }
}
