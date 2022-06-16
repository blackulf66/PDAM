package com.salesianos.triana.finalProyect.dto.user;

import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPost;
import com.salesianos.triana.finalProyect.model.UserRole;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetUserDto2 {

    private UUID userId;

    private String username;

    private String email;

    private String avatar;

    private LocalDateTime created;

    private List<Post> postList;

    private UserRole userRole;

    private List<SubPost> following;


}
