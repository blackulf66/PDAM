package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.post.CreatePostDto;
import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.post.PostDtoConverter;
import com.salesianos.triana.finalProyect.exception.SinComunidadException;
import com.salesianos.triana.finalProyect.exception.SingleEntityNotFoundException;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPost;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.service.PostService;
import io.github.techgnious.exception.VideoException;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
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
@Tag(name = "Post", description = "El controlador de post")

public class PostController {

    private final PostService Pservice;
    private final PostDtoConverter postDtoConverter;

    @Operation(summary = "crea un post")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "crea un nuevo post",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),

    })

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
    @Operation(summary = "borra un post por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "borrar un post pasandole un id",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra el post",
                    content = @Content),
    })

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePost(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) throws Exception {
        if (id.equals(null)){
            throw new SingleEntityNotFoundException(id.toString(), SubPost.class);
        }else{

            Pservice.deletePost(id);

            return status(204).build();
        }
    }
    @Operation(summary = "actualiza un post")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "actualizar un post pasandole un id",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra el post",
                    content = @Content),
    })

    @PutMapping("/{id}")
    public ResponseEntity<Optional<GetPostDto>> updatePost(@PathVariable Long id, @RequestPart("publicacion") CreatePostDto createPublicacionDto, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user) throws Exception {
        if (id.equals(null)){
            throw new SingleEntityNotFoundException(id.toString(), SubPost.class);
        }else{
            return status(HttpStatus.OK)
                    .body(Pservice.updatePost(id, createPublicacionDto, file, user));
        }


    }

    @Operation(summary = "Obtener un post por su nombre")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "obtener un post pasandole un nombre",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra el post",
                    content = @Content),
    })


    @GetMapping("/{nombre}")
    public ResponseEntity<GetPostDto> findOnePostbyname (@PathVariable String nombre, @AuthenticationPrincipal UserEntity user){

        GetPostDto publicacion = Pservice.findOnePost(nombre , user);

        return ResponseEntity.ok().body(publicacion);

    }
    @Operation(summary = "Obtener todos los post")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "obtienes todos los post de todas las comunidades",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
    })
    @GetMapping("all")
    public ResponseEntity<List<GetPostDto>> getAllPosts() {
        return status(HttpStatus.OK).body(Pservice.getAllPosts());
    }

    @Operation(summary = "Obtener todos los post por comunidad")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "obtener un post pasandole la id de la comunidad",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
    })
    @GetMapping("subpost/{id}")
    public ResponseEntity<List<GetPostDto>> getPostsBySubpost(@PathVariable Long id) {
        return status(HttpStatus.OK).body(Pservice.getPostsBysubpost(id));
    }


}
