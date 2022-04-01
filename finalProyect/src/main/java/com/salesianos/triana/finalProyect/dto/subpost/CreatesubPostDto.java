package com.salesianos.triana.finalProyect.dto.subpost;

import com.salesianos.triana.finalProyect.model.SubPosts;
import lombok.Builder;
import lombok.Value;
import com.salesianos.triana.finalProyect.model.UserEntity;

import java.time.Instant;

@Value
@Builder
public class CreatesubPostDto {

    private Long postId;

    private String imagenPortada;

    private String postName;

    private String description;

    private Integer voteCount = 0;

    private UserEntity userEntity;

    private Instant createdDate;

    private SubPosts subposts;
}




