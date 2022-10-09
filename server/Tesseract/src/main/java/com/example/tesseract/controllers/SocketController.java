package com.example.tesseract.controllers;

import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.listener.ConnectListener;
import com.corundumstudio.socketio.listener.DataListener;
import com.corundumstudio.socketio.listener.DisconnectListener;
import com.example.tesseract.models.OutputScan;
import com.example.tesseract.models.Scan;
import com.example.tesseract.services.ScanService;
import com.example.tesseract.services.SocketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class SocketController {
    private final SocketIOServer server;
    private final SocketService service;

    public SocketController(SocketIOServer server, SocketService service) {
        this.server = server;
        this.service = service;
        server.addConnectListener(onConnected());
        server.addDisconnectListener(onDisconnected());
        server.addEventListener("scan_image", Scan.class, onChatReceived());

    }

    private DataListener<Scan> onChatReceived() {
        return (senderClient, data, ackSender) -> {
            log.info(senderClient.getSessionId().toString() + " Отправил запрос!");
            service.sendText("get_text", senderClient, data);
        };
    }

    private ConnectListener onConnected() {
        return (client) -> {
            log.info("Socket ID[{}]  Connected to socket", client.getSessionId().toString());
        };

    }

    private DisconnectListener onDisconnected() {
        return client -> {
            log.info("Client[{}] - Disconnected from socket", client.getSessionId().toString());
        };
    }
}
