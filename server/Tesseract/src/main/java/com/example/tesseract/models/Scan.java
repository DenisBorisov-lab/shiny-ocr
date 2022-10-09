package com.example.tesseract.models;

import lombok.*;

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
