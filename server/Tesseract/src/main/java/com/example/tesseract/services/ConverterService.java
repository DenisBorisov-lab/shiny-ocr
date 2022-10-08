package com.example.tesseract.services;

import com.example.tesseract.models.Scan;
import lombok.SneakyThrows;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.UUID;

@Service
public class ConverterService {
    @SneakyThrows
    public File fromByteToImage(Scan object) {
        byte[] sequence = object.getImage();
        String type = object.getFormat();
        ByteArrayInputStream inStreambj = new ByteArrayInputStream(sequence);
        BufferedImage newImage = ImageIO.read(inStreambj);
        UUID randomUUID = UUID.randomUUID();
        String path = String.format("/src/main/resources/%s.$s", randomUUID, type);
        ImageIO.write(newImage, type, new File(path));
        return new File(path);
    }
}
