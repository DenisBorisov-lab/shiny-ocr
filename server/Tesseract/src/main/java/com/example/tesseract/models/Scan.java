package com.example.tesseract.models;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.UUID;

@Getter
@AllArgsConstructor
public class Scan {
    private String format;
    private byte[] image;
    private UUID userId;
}
