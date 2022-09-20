package com.example.tesseract.services;

import com.example.tesseract.models.Scan;
import lombok.SneakyThrows;
import net.sourceforge.tess4j.Tesseract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;

@Service
public class ScanService {

    private final ConverterService converterService;

    @Autowired
    public ScanService(ConverterService converterService) {
        this.converterService = converterService;
    }

    @SneakyThrows
    public String scan(Scan object) {
        String language = object.getLanguage();
        File image = converterService.fromByteToImage(object);
        Tesseract tesseract = new Tesseract();
        tesseract.setDatapath("src/main/resources");
        tesseract.setLanguage(language);
        tesseract.setPageSegMode(1);
        tesseract.setOcrEngineMode(1);
        return tesseract.doOCR(image);
    }
}
