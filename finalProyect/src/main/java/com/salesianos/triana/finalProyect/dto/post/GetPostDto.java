package com.salesianos.triana.finalProyect.dto.post;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetPostDto {

    private String imagenportada;

    private Long postId;

    private String postName;

    private String description;

    private UUID userEntityId;

    private Instant createdDate;

    private String subpostsName;

    private int VoteCount;


}
