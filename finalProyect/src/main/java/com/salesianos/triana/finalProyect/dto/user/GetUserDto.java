package com.salesianos.triana.finalProyect.dto.user;

import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserRole;
import lombok.*;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
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

    private String email;

    private String avatar;

    private LocalDateTime created;

    private List<SubPosts> subpostList;

    private UserRole userRole;


}
