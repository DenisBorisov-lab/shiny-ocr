package com.example.tesseract.services;

import com.corundumstudio.socketio.SocketIOClient;
import com.example.tesseract.models.OutputScan;
import com.example.tesseract.models.Scan;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class SocketService {
    private final ScanService scanService;
    public void sendText(String eventName, SocketIOClient client, Scan object){
//        OutputScan output = new OutputScan();
//        output.setUuid(object.getUserId());
//        output.setText(
//                scanService.scan(object)
//        );
        client.sendEvent(eventName, "Google");
    }
}
