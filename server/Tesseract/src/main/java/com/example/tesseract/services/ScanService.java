package com.example.tesseract.services;

import com.example.tesseract.models.Scan;
import lombok.SneakyThrows;
import net.sourceforge.tess4j.Tesseract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;

@Service
public class ScanService {

    private final ConverterService converterService;

    @Autowired
    public ScanService(ConverterService converterService) {
        this.converterService = converterService;
    }

    @SneakyThrows
    public String scan(Scan object) {
        File image = converterService.fromByteToImage(object);
        Tesseract tesseract = new Tesseract();
        tesseract.setDatapath("src/main/resources");
        tesseract.setLanguage("eng+rus+jpn+ita+deu+chi_sim+chi_tra+fra");
        tesseract.setPageSegMode(1);
        tesseract.setOcrEngineMode(1);
        String s = tesseract.doOCR(image);
        try{
            Files.delete(Paths.get(image.getPath()));
        }catch(Exception ex){
            System.out.println("Неудалось удалить файл!");
        }

        return s;
    }
}
