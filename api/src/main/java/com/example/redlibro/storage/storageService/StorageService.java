package com.example.redlibro.storage.storageService;
import com.example.redlibro.storage.exceptions.StorageException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class StorageService {
    @Value("${storage.location}")
    private String storageLocation;

    public String store(MultipartFile file) {
        try {
            byte[] bytes = file.getBytes();
            String filename = generateFilename(file.getOriginalFilename());
            Path path = Paths.get(storageLocation + "/" + filename);
            Files.write(path, bytes);
            return filename;
        } catch (IOException e) {
            throw new StorageException("Failed to store file " + file.getOriginalFilename(), e);
        }
    }

    private String generateFilename(String originalFilename) {
        // Aquí podrías implementar lógica para generar nombres de archivo únicos si es necesario
        return originalFilename;
    }
}
