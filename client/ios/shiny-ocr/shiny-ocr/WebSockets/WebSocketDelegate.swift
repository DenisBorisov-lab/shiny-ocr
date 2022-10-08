//
//  WebSocketDelegate.swift
//  WebSockets
//
//  Created by Igor Buzykin on 05.07.2022.
//

import Foundation

protocol WebSocketProvider {
    var delegate: WebSocketDelegate? { get set }
    var isConnected: Bool { get }
    func connect()
    func disconnect()
    func send(_ string: String)
    func send(_ data: Data)
}

protocol WebSocketDelegate: AnyObject {
    func webSocketDidConnect()
    func webSocketDidDisconnect()
    func webSocket(didReceiveString string: String)
    func webSocket(didReceiveData data: Data)
}
