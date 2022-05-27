package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.post.PostDtoConverter;
import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto2;
import com.salesianos.triana.finalProyect.dto.user.*;
import com.salesianos.triana.finalProyect.exception.SingleEntityNotFoundException;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserEntity;

import com.salesianos.triana.finalProyect.model.UserRole;
import com.salesianos.triana.finalProyect.model.Vote;
import com.salesianos.triana.finalProyect.service.UserEntityService;
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

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
@Transactional
@CrossOrigin("*")
@Tag(name = "User_Controller", description = "El controlador de usuarios")
public class UserController {

    private final UserEntityService userEntityService;
    private final UserDtoConverter userDtoConverter;
    private final PostDtoConverter postDtoConverter;

    @Operation(summary = "registrar usuario ")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "registras correctamente a un usuario",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se puede registrar , datos erroneos",
                    content = @Content),
    })
    @PostMapping("auth/register")
    public ResponseEntity<GetUserDto2> nuevoUsuario(@RequestParam("username") String username , @RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("role")UserRole role, @RequestPart MultipartFile file) throws IOException {

        CreateUserDto createUserDto = CreateUserDto.builder()
                .username(username)
                .email(email)
                .password(password)
                .userRole(role)
                .build();

        UserEntity saved = userEntityService.saveuser(createUserDto , file);
        if (saved == null)
            return ResponseEntity.badRequest().build();
        else
            return ResponseEntity.ok(userDtoConverter.convertUserEntityToGetUserDto(saved));
    }
    @Operation(summary = "obtener un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "obtienes un usuario buscado por id",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra ese usuario",
                    content = @Content),
    })
    @GetMapping("user/{username}")
    public ResponseEntity<GetUserDto> finduserByName(@PathVariable String username, @AuthenticationPrincipal UserEntity user){
        Optional<UserEntity> uOptional = userEntityService.finduserByName(username);

        if(uOptional.isEmpty()){
            return ResponseEntity.notFound().build();

        }else{
            return ResponseEntity.ok().body(userDtoConverter.convertUserEntityToGetUserDto2(uOptional.get()));
        }

    }
    @Operation(summary = "seguir una comunidad(subpost)")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "sigues a una comundad pasando su id",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra esa comunidad",
                    content = @Content),
    })
    @GetMapping("follow/{id}")
    public ResponseEntity<?> followsubpost(@AuthenticationPrincipal UserEntity user, @PathVariable Long id){
        userEntityService.addfollow(user , id);
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "dejar de seguir una comunidad(subpost)")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "sigues a una comundad pasando su id",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no sigues a esa comunidad para dejar de seguirla",
                    content = @Content),
    })

    @GetMapping("unfollow/{id}")
    public ResponseEntity<?> unfollowsubpost(@AuthenticationPrincipal UserEntity user, @PathVariable Long id){
        userEntityService.removefollow(id , user);
        return ResponseEntity.ok().build();
    }
    @Operation(summary = "actualizar usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "acualizar a tu usuario",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra el usuario",
                    content = @Content),
    })
    @PutMapping("/{id}")
    public ResponseEntity<Optional<GetUserDto2>> updateuser(@RequestPart("publicacion") CreateUserDto createUserDtoDto, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user) throws Exception {
        if (user.getUserId().equals(null)){
            throw new SingleEntityNotFoundException(user.getUserId().toString(), SubPosts.class);
        }else{
            return ResponseEntity.status(HttpStatus.OK)
                    .body(userEntityService.updateUser(createUserDtoDto, file, user));
        }

    }

    @Operation(summary = "obtener todos los post")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "obtener todos los post ",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se encuentra el usuario",
                    content = @Content),
    })
    @GetMapping("user/all")
    public ResponseEntity<List<GetUserDto>> getAllPosts() {
        return status(HttpStatus.OK).body(userEntityService.getAllusers());
    }

    @GetMapping("user/allfollows")
    public ResponseEntity<List<GetFollowsDto>> getAllfollowsSubPosts(@AuthenticationPrincipal UserEntity user) {
        return status(HttpStatus.OK).body(userEntityService.getAllfollows());
    }






    /*
    @PutMapping("user/{id}")
    public ResponseEntity<Optional<GetUserDto2>> updatePublicacion(@PathVariable UUID id, @RequestPart("user") CreateUserDto updateUser, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user) throws EntityNotFoundException {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(userEntityService.updateUser(id, updateUser, file , user));


    }*/

}