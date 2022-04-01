package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.SubPostDtoConverter;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;
import com.salesianos.triana.finalProyect.service.FileSystemStorageService;
import com.salesianos.triana.finalProyect.service.SubPostsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import javax.management.Query;
import java.io.IOException;
import java.util.Optional;

@RestController
@RequestMapping("/subpost")
@RequiredArgsConstructor
public class SubPostController {

    private final SubPostsService Pservice;
    private final SubPostsRepository postRepository;
    private final SubPostDtoConverter postDtoConverter;
    private final FileSystemStorageService fileSystemStorageService;

    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestParam("nombre") String nombre,
                                    @RequestParam("descripcion") String description,
                                    @AuthenticationPrincipal UserEntity user) throws IOException {

        CreateSubPostDto newPost = CreateSubPostDto.builder()
                .nombre(nombre)
                .descripcion(description)
                .build();

        SubPosts subPostCreated = Pservice.save(newPost, file , user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(postDtoConverter.subPostToGetSubPostDto(subPostCreated));
    }
/*
    @PutMapping("/{id}")
    public ResponseEntity<Optional<GetSubPostDto>> updatePublicacion(@PathVariable Long id, @RequestPart("post") CreateSubPostDto updatePost, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user) throws Exception {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(Pservice.updatePost(id, updatePost, file , user));

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePost(@PathVariable Long id) throws Exception {

        Optional<Post> pOptional = Pservice.findPostById(id);

        if (id.equals(null)){
            throw new FileNotFoundException("no se encuentra el archivo");
        }else{
            fileSystemStorageService.deleteFile(pOptional.get().getImagenportada());
            Pservice.deletePost(id);
            return ResponseEntity.noContent().build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<GetPostDto> findpostbyID(@PathVariable Long id, @AuthenticationPrincipal UserEntity user){
        Optional<Post> postOptional = Pservice.findPostById(id);

        if(postOptional.isEmpty()){
            return ResponseEntity.notFound().build();

        }else{
            return ResponseEntity.ok().body(postDtoConverter.postToGetPostDto(postOptional.get()));
        }

        }
    @GetMapping("/")
    public ResponseEntity<List<GetPostDto>> listAllPostByNick(@RequestParam(value = "nick") String nick, @AuthenticationPrincipal UserEntity u){
        List<GetPostDto> publi = Pservice.findPostByUserNickname(nick, u);
        if(u==null){
            throw new EntityNotFoundException("El nick no existe");
        }else{
            return ResponseEntity.ok().body(publi);
        }
    }*/
}