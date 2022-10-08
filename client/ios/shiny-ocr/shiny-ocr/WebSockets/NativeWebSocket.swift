//
//  WebSocketManager.swift
//  WebSockets
//
//  Created by Igor Buzykin on 20.05.2022.
//

import Foundation

class NativeWebSocket: NSObject, WebSocketProvider {
    weak var delegate: WebSocketDelegate?
    var isConnected: Bool = false

    private let url: URL
    private var socket: URLSessionWebSocketTask?
    private var urlSession: URLSession?

    init(url: URL) {
        self.url = url
        super.init()
    }
    
    deinit {
        print("NativeSocket has been replaced on StarscreamSocket")
    }

    func connect() {
        let urlSession = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: nil
        )
        self.urlSession = urlSession
        socket = urlSession.webSocketTask(with: url)
        socket?.resume()
        receiveMessage()
    }

    func disconnect() {
        socket?.cancel(with: .goingAway, reason: nil)
        socket = nil
        urlSession?.invalidateAndCancel()
        urlSession = nil
    }

    func send(_ string: String) {
        socket?.send(.string(string)) { error in
            guard let error = error else { return }
            let errorDescription = error.localizedDescription
            print("Sending the message failed! Error: \(errorDescription)")
        }
    }

    func send(_ data: Data) {
        socket?.send(.data(data)) { error in
            guard let error = error else { return }
            let errorDescription = error.localizedDescription
            print("Sending the message failed! Error: \(errorDescription)")
        }
    }

    private func receiveMessage() {
        socket?.receive { [weak self] message in
            guard let self = self else { return }
            switch message {
            case let .success(message):
                switch message {
                case let .data(recivedData):
                    DispatchQueue.main.async {
                        self.delegate?.webSocket(didReceiveData: recivedData)
                    }
                case let .string(recivedString):
                    DispatchQueue.main.async {
                        self.delegate?.webSocket(didReceiveString: recivedString)
                    }
                @unknown default:
                    print("WebSocket did receive Unknown Type!")
                }
                self.receiveMessage()
            case .failure:
                self.disconnect()
            }
        }
    }
}

extension NativeWebSocket: URLSessionWebSocketDelegate {
    func urlSession(
        _: URLSession,
        webSocketTask _: URLSessionWebSocketTask,
        didOpenWithProtocol _: String?
    ) {
        isConnected = true
        DispatchQueue.main.async {
            self.delegate?.webSocketDidConnect()
        }
    }

    func urlSession(
        _: URLSession,
        webSocketTask _: URLSessionWebSocketTask,
        didCloseWith _: URLSessionWebSocketTask.CloseCode,
        reason _: Data?
    ) {
        isConnected = false
        DispatchQueue.main.async {
            self.delegate?.webSocketDidDisconnect()
        }
    }
}
