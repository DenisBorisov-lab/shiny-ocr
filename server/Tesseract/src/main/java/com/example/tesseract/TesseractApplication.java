package com.example.tesseract;

import lombok.SneakyThrows;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class TesseractApplication {

    @SneakyThrows
    public static void main(String[] args) {
        SpringApplication.run(TesseractApplication.class, args);
    }

}

