package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.post.CreatePostDto;
import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.post.PostDtoConverter;
import com.salesianos.triana.finalProyect.model.Categoria;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.repository.PostRepository;
import com.salesianos.triana.finalProyect.service.FileSystemStorageService;
import com.salesianos.triana.finalProyect.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import java.io.IOException;
import java.util.Optional;

@RestController
@RequestMapping("/post")
@RequiredArgsConstructor
public class PostController {

    private final PostService Pservice;
    private final PostRepository postRepository;
    private final PostDtoConverter postDtoConverter;
    private final FileSystemStorageService fileSystemStorageService;

    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestParam("postname") String postName,
                                    @RequestParam("descripcion") String description,
                                    @AuthenticationPrincipal UserEntity user) throws IOException {
        CreatePostDto newPost = CreatePostDto.builder()
                .postName(postName)
                .description(description)
                .build();

        Post postCreated = Pservice.save(newPost, file , user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(postDtoConverter.postToGetPostDto(postCreated));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Optional<GetPostDto>> updatePublicacion(@PathVariable Long id, @RequestPart("post") CreatePostDto updatePost, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user) throws Exception {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(Pservice.updatePost(id, updatePost, file , user));

    }

   /* @DeleteMapping("/{id}")
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