package com.salesianos.triana.finalProyect.service;

import io.github.techgnious.exception.VideoException;
import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.nio.file.Path;
import java.util.stream.Stream;

public interface StorageService {

    void init();

    String original(MultipartFile file);

    Stream<Path> loadAll();

    Path load(String filename);

    Resource loadAsResource(String filename);

    void deleteFile(Path filename) throws IOException;

    void deleteFile2(String uri) throws IOException;

    void deleteAll();

    String escalado(MultipartFile file, int size) throws IOException;

    String videoEscalado(MultipartFile file) throws IOException, VideoException;



}
