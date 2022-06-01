package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto2;
import com.salesianos.triana.finalProyect.dto.subpost.SubPostDtoConverter;
import com.salesianos.triana.finalProyect.exception.NotAdminException;
import com.salesianos.triana.finalProyect.exception.SingleEntityNotFoundException;
import com.salesianos.triana.finalProyect.model.SubPost;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;
import com.salesianos.triana.finalProyect.service.FileSystemStorageServiceimpl;
import com.salesianos.triana.finalProyect.service.SubPostsService;
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
@CrossOrigin("*")
@Transactional
@RequestMapping("/subpost")
@RequiredArgsConstructor
@Tag(name = "subpost", description = "El controlador de subpost")
public class SubPostController {

    private final SubPostsService SPservice;
    private final SubPostsRepository postRepository;
    private final SubPostDtoConverter subpostDtoConverter;
    private final FileSystemStorageServiceimpl fileSystemStorageServiceimpl;

    @Operation(summary = "crear subpost")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "crea un subport nuevo",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra el usuario",
                    content = @Content),
    })

    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestParam("nombre") String nombre,
                                    @RequestParam("descripcion") String description,
                                    @AuthenticationPrincipal UserEntity user) throws IOException, VideoException, NotAdminException {

        CreateSubPostDto newPost = CreateSubPostDto.builder()
                .nombre(nombre)
                .descripcion(description)
                .build();

        SubPost subPostCreated = SPservice.save(newPost, file , user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(subpostDtoConverter.subPostToGetSubPostDto(subPostCreated));
    }

    @Operation(summary = "obtener todos los subpost")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "obtiene todos los subpost",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
    })
    @GetMapping("all")
    public ResponseEntity<List<GetSubPostDto2>> getAllPosts() {
        return status(HttpStatus.OK).body(SPservice.getAllSubPosts());
    }

    @Operation(summary = "borrar subpost")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "borra todos los subpost y post vinculados a este",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra el subpost",
                    content = @Content),
    })

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteSubPost(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) throws Exception {
        if (id.equals(null)){
            throw new SingleEntityNotFoundException(id.toString(), SubPost.class);
        }else{

            SPservice.deleteSubpost2(id);

            return ResponseEntity.status(204).build();
        }
    }
    @Operation(summary = "acualizar subpost")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "actualiza el subpost ",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra el subpost",
                    content = @Content),
    })

    @PutMapping("/{id}")
    public ResponseEntity<Optional<GetSubPostDto>> updatesubPost(@PathVariable Long id, @RequestPart("publicacion") CreateSubPostDto createPublicacionDto, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user) throws Exception {
        if (id.equals(null)){
            throw new SingleEntityNotFoundException(id.toString(), SubPost.class);
        }else{
            return ResponseEntity.status(HttpStatus.OK)
                    .body(SPservice.updateSubPost(id, createPublicacionDto, file, user));
        }


    }
    @Operation(summary = "buscar un subpost por nombre")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "busca el subpost por su nombre",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = SubPost.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra el subpost",
                    content = @Content),
    })

    @GetMapping("/{nombre}")
    public ResponseEntity<GetSubPostDto2> findOnesubPost (@PathVariable String nombre, @AuthenticationPrincipal UserEntity user){

        GetSubPostDto2 publicacion = SPservice.findOneSubPost(nombre , user);

        return ResponseEntity.ok().body(publicacion);

    }

}