package com.example.tesseract.controllers;

import com.example.tesseract.models.OutputScan;
import com.example.tesseract.models.Scan;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class ScanController {
    @MessageMapping("/scanner")
    @SendTo("/server/scan")
    public OutputScan send(Scan scan) {
        return null;
    }
}
