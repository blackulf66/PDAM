package com.salesianos.triana.finalProyect.dto.user;

import com.salesianos.triana.finalProyect.dto.post.GetPostDto2;
import com.salesianos.triana.finalProyect.model.Post;
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
public class GetUserDto3 {

    private UUID userId;

    private String username;

    private String email;

    private String avatar;

    private LocalDateTime created;

    private List<GetPostDto2> postList;

    private UserRole userRole;


}
