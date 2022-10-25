package com.example.tesseract.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

    @PostMapping("/scan_image")
    public ResponseEntity scan() {
        // взаимодействие с сокетом
        return ResponseEntity.ok().build();
    }

}
