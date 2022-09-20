package com.example.tesseract.server;

import com.example.tesseract.models.Scan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.UUID;

@Service
public class ScanService {

    private final ConverterService converterService;

    @Autowired
    public ScanService(ConverterService converterService){
        this.converterService = converterService;
    }

    public void scan(Scan object){
        UUID UserId = object.getUserId();
        File image = converterService.fromByteToImage(object);
    }
}
