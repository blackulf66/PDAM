package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.post.CreatePostDto;
import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.post.PostDtoConverter;
import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.exception.SinComunidadException;
import com.salesianos.triana.finalProyect.exception.SingleEntityNotFoundException;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
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
import java.util.List;
import java.util.Optional;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequiredArgsConstructor
@CrossOrigin("*")
@RequestMapping("/post")
@Transactional
public class PostController {

    private final PostService Pservice;
    private final PostDtoConverter postDtoConverter;


    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestParam("nombre") String nombre,
                                    @RequestParam("descripcion") String description,
                                    @RequestParam("subpost") String SubPostName,
                                    @AuthenticationPrincipal UserEntity user) throws IOException, VideoException, SinComunidadException {

        CreatePostDto newPost = CreatePostDto.builder()
                .postName(nombre)
                .description(description)
                .build();

        Post PostCreated = Pservice.save(newPost, file , user ,SubPostName);

        return status(HttpStatus.CREATED)
                .body(postDtoConverter.PostToGetPostDto(PostCreated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePost(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) throws Exception {
        if (id.equals(null)){
            throw new SingleEntityNotFoundException(id.toString(), SubPosts.class);
        }else{

            Pservice.deletePost(id);

            return status(204).build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Optional<GetPostDto>> updatePost(@PathVariable Long id, @RequestPart("publicacion") CreatePostDto createPublicacionDto, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user) throws Exception {
        if (id.equals(null)){
            throw new SingleEntityNotFoundException(id.toString(), SubPosts.class);
        }else{
            return status(HttpStatus.OK)
                    .body(Pservice.updatePost(id, createPublicacionDto, file, user));
        }


    }

    @GetMapping("/{nombre}")
    public ResponseEntity<GetPostDto> findOnePostbyname (@PathVariable String nombre, @AuthenticationPrincipal UserEntity user){

        GetPostDto publicacion = Pservice.findOnePost(nombre , user);

        return ResponseEntity.ok().body(publicacion);

    }

    @GetMapping("all")
    public ResponseEntity<List<GetPostDto>> getAllPosts() {
        return status(HttpStatus.OK).body(Pservice.getAllPosts());
    }


    @GetMapping("subpost/{id}")
    public ResponseEntity<List<GetPostDto>> getPostsBySubreddit(@PathVariable Long id) {
        return status(HttpStatus.OK).body(Pservice.getPostsBySubreddit(id));
    }


}
