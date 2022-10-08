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
  
  func connectToTesseractServer() {
    webSocket.delegate = self
    webSocket.connect()
  }
    
  func scan(_ scan: SendingScan) {
    webSocket.send(Data())
  }
}

extension ScannerManager: WebSocketDelegate {
  func webSocketDidConnect() {
    print("Socket did connect")
    delegate?.unlockScanActions()
  }
    
  func webSocketDidDisconnect() {
    print("Socket did disconnect")
    delegate?.lockScanActions()
  }
    
  func webSocket(didReceiveString string: String) {
    print("WARN: web socket reveice string! Expected type: Data")
  }
    
  func webSocket(didReceiveData data: Data) {
    guard let receivedScan = try? JSONDecoder().decode(RecivedScan.self, from: data) else { return }
    delegate?.scannerManager(self, didReceiveScan: receivedScan)
  }
}
