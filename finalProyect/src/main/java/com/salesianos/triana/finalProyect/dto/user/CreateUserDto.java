package com.salesianos.triana.finalProyect.dto.user;


import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import lombok.*;

import java.time.Instant;
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

    private Instant created;

    private List<SubPosts> subpostList;


}
