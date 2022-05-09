package com.salesianos.triana.finalProyect.security;


import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.dto.user.GetUserDto;
import com.salesianos.triana.finalProyect.dto.user.GetUserDto2;
import com.salesianos.triana.finalProyect.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import com.salesianos.triana.finalProyect.security.dto.JwtUserResponse;
import com.salesianos.triana.finalProyect.security.dto.LoginDto;
import com.salesianos.triana.finalProyect.security.jwt.JwtProvider;

import javax.transaction.Transactional;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
@CrossOrigin
public class AuthenticationController {

    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;
    private final UserEntityService userEntityService;

    String jwt="";

    @PostMapping("auth/login")
    public ResponseEntity<?> login(@RequestBody LoginDto loginDto) {

        Authentication authentication =
                authenticationManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginDto.getEmail(),
                                loginDto.getPassword()
                        )
                );

        SecurityContextHolder.getContext().setAuthentication(authentication);

        jwt = jwtProvider.generateToken(authentication);
        UserEntity user = (UserEntity) authentication.getPrincipal();

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(convertUserToJwtUserResponse(user, jwt));

    }


    private JwtUserResponse convertUserToJwtUserResponse(UserEntity user, String jwt) {
        return JwtUserResponse.builder()
                .email(user.getEmail())
                .avatar(user.getAvatar())
                .username(user.getUsername())
                .userRole(user.getUserRole().name())
                .fecha(user.getCreated())
                .posts(user.getPosts().stream().map(p -> new GetPostDto(p.getImagenportada(),p.getPostId(),p.getPostName(),p.getDescription(),p.getUserEntity().getUserId(),p.getCreatedDate(),p.getSubposts().getNombre())).toList())
                .subPosts(user.getSubPostsList().stream().map(p -> new GetSubPostDto(p.getImagen(),p.getId(),p.getNombre(),p.getDescripcion(),p.getCreatedDate(),p.getPosts(),p.getUserEntity().getUserId())).toList())
                .token(jwt)
                .build();
    }

    @GetMapping("/me")
    public ResponseEntity<?> me(@AuthenticationPrincipal UserEntity userPrincipal) {

        GetUserDto getUserDto = userEntityService.verPerfil(userPrincipal);

        return ResponseEntity.status(HttpStatus.OK)
                .body(getUserDto);
    }


}