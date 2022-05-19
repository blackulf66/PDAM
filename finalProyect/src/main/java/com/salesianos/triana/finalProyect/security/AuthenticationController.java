package com.salesianos.triana.finalProyect.security;


import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.dto.user.GetUserDto;
import com.salesianos.triana.finalProyect.dto.user.GetUserDto2;
import com.salesianos.triana.finalProyect.service.UserEntityService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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
@CrossOrigin("*")
public class AuthenticationController {
    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;
    private final UserEntityService userEntityService;

    String jwt="";

    @Operation(summary = "loguear un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "logueas a un usuario",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),

    })

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
                .posts(user.getPosts().stream().map(p -> new GetPostDto(p.getImagenportada(),p.getPostId(),p.getPostName(),p.getDescription(),p.getUserEntity().getUserId(),p.getCreatedDate(),p.getSubposts().getNombre(),p.getVoteCount())).toList())
                .subPosts(user.getSubPostsList().stream().map(p -> new GetSubPostDto(p.getImagen(),p.getId(),p.getNombre(),p.getDescripcion(),p.getCreatedDate(),p.getPosts(),p.getUserEntity().getUserId())).toList())
                .token(jwt)
                .build();
    }
    @Operation(summary = "obtener datos de usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "obienes todo del usuario logueado",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))})
    })
    @GetMapping("/me")
    public ResponseEntity<?> me(@AuthenticationPrincipal UserEntity userPrincipal) {

        GetUserDto getUserDto = userEntityService.verPerfil(userPrincipal);

        return ResponseEntity.status(HttpStatus.OK)
                .body(getUserDto);
    }


}