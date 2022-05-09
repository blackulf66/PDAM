package com.salesianos.triana.finalProyect.dto.post;


import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreatePostDto {

    private String imagenportada;

    private Long postId;

    private String postName;

    private String description;

    private UserEntity userEntity;

    private Instant createdDate;

    private SubPosts subPosts;
}
