package com.example.tesseract.models;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

import java.util.UUID;

@Data
@NoArgsConstructor
public class Scan {
    @NonNull
    private String format;
    private byte[] image;
    @NonNull
    private UUID userId;
}
