package com.salesianos.triana.finalProyect.controller;


import com.salesianos.triana.finalProyect.dto.user.CreateUserDto;
import com.salesianos.triana.finalProyect.dto.user.GetUserDto;
import com.salesianos.triana.finalProyect.dto.user.UserDtoConverter;
import com.salesianos.triana.finalProyect.model.UserEntity;

import com.salesianos.triana.finalProyect.model.UserRole;
import com.salesianos.triana.finalProyect.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/")
@Transactional

public class UserController {

    private final UserEntityService userEntityService;
    private final UserDtoConverter userDtoConverter;


    @PostMapping("auth/register")
    public ResponseEntity<GetUserDto> nuevoUsuario(@RequestParam("username") String username , @RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("role")UserRole role, @RequestPart MultipartFile file) throws IOException {

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

    @GetMapping("user/{id}")
    public ResponseEntity<GetUserDto> finduserById(@PathVariable UUID id, @AuthenticationPrincipal UserEntity user){
        Optional<UserEntity> uOptional = userEntityService.findById(id);

        if(uOptional.isEmpty()){
            return ResponseEntity.notFound().build();

        }else{
            return ResponseEntity.ok().body(userDtoConverter.convertUserEntityToGetUserDto(uOptional.get()));
        }

    }
    @PutMapping("user/{id}")
    public ResponseEntity<Optional<GetUserDto>> updatePublicacion(@PathVariable UUID id, @RequestPart("user") CreateUserDto updateUser, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user) throws EntityNotFoundException {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(userEntityService.updateUser(id, updateUser, file , user));

    }

    @PutMapping("profile/me")
    public ResponseEntity<Optional<GetUserDto>> actualizarPerfil (@AuthenticationPrincipal UserEntity userEntity, @RequestPart("user") CreateUserDto createUserDto, @RequestPart("file")MultipartFile file) throws Exception {

        return ResponseEntity.ok(userEntityService.actualizarPerfil(userEntity, createUserDto, file));
    }

    }

