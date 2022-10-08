package com.example.tesseract.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NonNull;

import java.util.UUID;

@Getter
@AllArgsConstructor
public class Scan {
    @NonNull
    private String format;
    private byte[] image;
    @NonNull
    private UUID userId;
}
