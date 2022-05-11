package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto2;
import com.salesianos.triana.finalProyect.dto.subpost.SubPostDtoConverter;
import com.salesianos.triana.finalProyect.exception.ListEntityNotFoundException;
import com.salesianos.triana.finalProyect.exception.NotAdminException;
import com.salesianos.triana.finalProyect.exception.SingleEntityNotFoundException;
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
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import static org.springframework.http.ResponseEntity.status;

@RestController
@CrossOrigin("*")
@Transactional
@RequestMapping("/subpost")
@RequiredArgsConstructor
public class SubPostController {

    private final SubPostsService SPservice;
    private final SubPostsRepository postRepository;
    private final SubPostDtoConverter subpostDtoConverter;
    private final FileSystemStorageServiceimpl fileSystemStorageServiceimpl;

    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestParam("nombre") String nombre,
                                    @RequestParam("descripcion") String description,
                                    @AuthenticationPrincipal UserEntity user) throws IOException, VideoException, NotAdminException {

        CreateSubPostDto newPost = CreateSubPostDto.builder()
                .nombre(nombre)
                .descripcion(description)
                .build();

        SubPosts subPostCreated = SPservice.save(newPost, file , user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(subpostDtoConverter.subPostToGetSubPostDto(subPostCreated));
    }

    @GetMapping("all")
    public ResponseEntity<List<GetSubPostDto2>> getAllPosts() {
        return status(HttpStatus.OK).body(SPservice.getAllSubPosts());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteSubPost(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) throws Exception {
        if (id.equals(null)){
            throw new SingleEntityNotFoundException(id.toString(), SubPosts.class);
        }else{

            SPservice.deleteSubpost2(id);

            return ResponseEntity.status(204).build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Optional<GetSubPostDto>> updatesubPost(@PathVariable Long id, @RequestPart("publicacion") CreateSubPostDto createPublicacionDto, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user) throws Exception {
        if (id.equals(null)){
            throw new SingleEntityNotFoundException(id.toString(), SubPosts.class);
        }else{
            return ResponseEntity.status(HttpStatus.OK)
                    .body(SPservice.updateSubPost(id, createPublicacionDto, file, user));
        }


    }

    @GetMapping("/{nombre}")
    public ResponseEntity<GetSubPostDto> findOnesubPost (@PathVariable String nombre, @AuthenticationPrincipal UserEntity user){

        GetSubPostDto publicacion = SPservice.findOneSubPost(nombre , user);

        return ResponseEntity.ok().body(publicacion);

    }
/*
    @GetMapping("/all")
    public ResponseEntity<List<GetSubPostDto>> findAllSubpost(){

        if (SPservice.findAllSubPost().isEmpty()){
            throw new ListEntityNotFoundException(SubPosts.class);
        }else{
            List<GetSubPostDto> list = SPservice.findAllSubPost().stream()
                    .map(subpostDtoConverter::createsubPostDtoTosubPost)
                    .collect(Collectors.toList());
            return ResponseEntity.ok().body(list);
        }


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