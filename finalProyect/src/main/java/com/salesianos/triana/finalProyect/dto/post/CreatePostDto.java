package com.salesianos.triana.finalProyect.dto.post;

import com.salesianos.triana.finalProyect.model.Categoria;
import com.salesianos.triana.finalProyect.model.SubPosts;
import lombok.Builder;
import lombok.Value;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.lang.Nullable;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.UUID;

import static javax.persistence.FetchType.LAZY;
import static javax.persistence.GenerationType.IDENTITY;

@Value
@Builder
public class CreatePostDto {

    private Long postId;

    private String imagenPortada;

    private String postName;

    private String description;

    private Integer voteCount = 0;

    private UserEntity userEntity;

    private Instant createdDate;

    private SubPosts subposts;
}




