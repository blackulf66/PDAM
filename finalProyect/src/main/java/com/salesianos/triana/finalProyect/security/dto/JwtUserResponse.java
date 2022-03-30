package com.salesianos.triana.finalProyect.security.dto;

import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserRole;
import lombok.*;

import java.time.LocalDateTime;
import java.util.Date;
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
    private List<SubPosts> subPosts;

}