package com.salesianos.triana.finalProyect.dto.user;


import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.model.UserRole;
import lombok.*;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateUserDto {

    private String username;

    private String password;

    private String email;

    private String avatar;

    private LocalDateTime created;

    private List<Post> postList;

    private UserRole userRole;

    private List<UserEntity> following;


}
