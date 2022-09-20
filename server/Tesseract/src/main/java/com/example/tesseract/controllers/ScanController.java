package com.example.tesseract.controllers;

import com.example.tesseract.models.OutputScan;
import com.example.tesseract.models.Scan;
import com.example.tesseract.services.ScanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import java.util.UUID;

@Controller
public class ScanController {

    private ScanService scanService;

    @Autowired
    public ScanController(ScanService scanService) {
        this.scanService = scanService;
    }

    @MessageMapping("/scanner")
    @SendTo("/server/scan")
    public OutputScan send(Scan object) {
        UUID userId = object.getUserId();
        String text = scanService.scan(object);
        return new OutputScan(userId, text);
    }
}
