package com.salesianos.triana.finalProyect.dto.post;

import com.salesianos.triana.finalProyect.model.Categoria;
import com.salesianos.triana.finalProyect.model.SubPosts;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.salesianos.triana.finalProyect.model.UserEntity;

import java.time.Instant;
import java.util.UUID;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetPostDto {

    private String imagenPortada;

    private Long postId;

    private String postName;

    private String description;

    private Integer voteCount = 0;

    private UserEntity userEntity;

    private Instant createdDate;

    private Categoria categoria;

    private SubPosts subposts;
}





