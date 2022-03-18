package com.salesianos.triana.finalProyect.dto.user;

import com.salesianos.triana.finalProyect.model.SubPosts;
import lombok.*;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetUserDto {

    private UUID userId;

    private String username;

    private String password;

    private String email;

    private String avatar;

    private Instant created;

    private List<SubPosts> subpostList;


}
