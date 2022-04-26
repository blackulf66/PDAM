package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.post.CreatePostDto;
import com.salesianos.triana.finalProyect.dto.post.PostDtoConverter;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.service.PostService;
import io.github.techgnious.exception.VideoException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import javax.transaction.Transactional;
import java.io.IOException;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/post")
@Transactional
public class PostController {

    private final PostService Pservice;
    private final PostDtoConverter postDtoConverter;


    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestParam("nombre") String nombre,
                                    @RequestParam("descripcion") String description,
                                    @RequestParam("subpost") Long postid,
                                    @AuthenticationPrincipal UserEntity user) throws IOException, VideoException {

        CreatePostDto newPost = CreatePostDto.builder()
                .postName(nombre)
                .description(description)
                .postId(postid)
                .build();

        Post PostCreated = Pservice.save(newPost, file , user );

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(postDtoConverter.PostToGetPostDto(PostCreated));
    }
}
