package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.FileResponse;
import com.salesianos.triana.finalProyect.service.StorageService;
import com.salesianos.triana.finalProyect.utils.MediaTypeUrlResource;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@RestController
@RequiredArgsConstructor
@CrossOrigin("http://localhost:8080")
public class FileController {

    private final StorageService storageService;


    @GetMapping("/download/{filename:.+}")
    public ResponseEntity<Resource> getFile(@PathVariable String filename) {
        MediaTypeUrlResource resource = (MediaTypeUrlResource) storageService.loadAsResource(filename);


        return ResponseEntity.status(HttpStatus.OK)
                .header("content-type", resource.getType())
                .body(resource);


    }

}