package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.SubPostDtoConverter;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;
import com.salesianos.triana.finalProyect.service.FileSystemStorageServiceimpl;
import com.salesianos.triana.finalProyect.service.SubPostsService;
import io.github.techgnious.exception.VideoException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import javax.transaction.Transactional;
import javax.validation.Valid;
import java.io.IOException;

@RestController
@CrossOrigin
@Transactional
@RequestMapping("/subpost")
@RequiredArgsConstructor
public class SubPostController {

    private final SubPostsService SPservice;
    private final SubPostsRepository postRepository;
    private final SubPostDtoConverter postDtoConverter;
    private final FileSystemStorageServiceimpl fileSystemStorageServiceimpl;

    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestParam("nombre") String nombre,
                                    @RequestParam("descripcion") String description,
                                    @AuthenticationPrincipal UserEntity user) throws IOException, VideoException {

        CreateSubPostDto newPost = CreateSubPostDto.builder()
                .nombre(nombre)
                .descripcion(description)
                .build();

        SubPosts subPostCreated = SPservice.save(newPost, file , user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(postDtoConverter.subPostToGetSubPostDto2(subPostCreated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePost(@AuthenticationPrincipal UserEntity user, @PathVariable Long id) throws IOException {
        return SPservice.deleteSubPost(user ,id);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> editPost(@RequestPart("file") MultipartFile file, @Valid @RequestPart("subpost") CreateSubPostDto createsubPostDto, @AuthenticationPrincipal UserEntity userPrincipal, @PathVariable Long id) throws IOException, VideoException {
        SubPosts saved = SPservice.editSubPost(createsubPostDto, file, userPrincipal, id);

        if (saved == null)
            return ResponseEntity.badRequest().build();
        else
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(postDtoConverter.subPostToGetSubPostDto(saved));
    }

/*
    @GetMapping("all")
    public ResponseEntity<List<GetSubPostDto>> getAllPostPublic(@PathVariable Long id) throws IOException {
        if(SPservice.getAllSubpost(id).isEmpty()){
            throw new ListEntityNotFoundException(SubPosts.class);
        }else{
            return ResponseEntity.ok().body(SPservice.getAllSubpost(id));
        }
    }
/*
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