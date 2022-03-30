package com.salesianos.triana.finalProyect.security;


import com.salesianos.triana.finalProyect.dto.post.PostDtoConverter;
import lombok.RequiredArgsConstructor;
import com.salesianos.triana.finalProyect.model.UserEntity;
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

import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
@CrossOrigin

public class AuthenticationController {

    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;

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

    @GetMapping("me")
    public ResponseEntity<?> tusdatos(@AuthenticationPrincipal UserEntity user){
        return ResponseEntity.ok(convertUserToJwtUserResponse(user, jwt));
    }

    private JwtUserResponse convertUserToJwtUserResponse(UserEntity user, String jwt) {
        return JwtUserResponse.builder()
                .email(user.getEmail())
                .avatar(user.getAvatar())
                .username(user.getUsername())
                .userRole(user.getUserRole().name())
                .fecha(user.getCreated())
                .subPosts(user.getSubposts())
                .token(jwt)
                .build();
    }

}