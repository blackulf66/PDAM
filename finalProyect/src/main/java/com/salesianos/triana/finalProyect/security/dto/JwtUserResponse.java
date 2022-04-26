package com.salesianos.triana.finalProyect.security.dto;

import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.model.SubPosts;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class JwtUserResponse {

    private String email;
    private String avatar;
    private String username;
    private String token;
    private String userRole;
    private LocalDateTime fecha;
    private List<GetSubPostDto> subPosts;

}