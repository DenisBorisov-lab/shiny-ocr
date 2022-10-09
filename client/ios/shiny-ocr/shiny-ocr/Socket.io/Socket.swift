//
//  Socket.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 10.10.2022.
//

import Foundation
import SocketIO

protocol SocketIODelegate: AnyObject {
  func receiveData(_ data: Data)
}

class SocketIO {
  weak var delegate: SocketIODelegate?
  var isConnected = false

  private let manager: SocketManager
  private let socket: SocketIOClient
  
  init(url: URL) {
    self.manager = SocketManager(socketURL: url)
    self.socket = manager.defaultSocket
  }

  func connect() {
    socket.connect()
  }

  func disconnect() {
    socket.disconnect()
  }

  func send() {
//    socket.emit(<#T##event: String##String#>, <#T##items: SocketData...##SocketData#>)
  }
}
