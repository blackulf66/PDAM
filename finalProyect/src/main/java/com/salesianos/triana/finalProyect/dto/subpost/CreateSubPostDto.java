package com.salesianos.triana.finalProyect.dto.subpost;

import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import lombok.Builder;
import lombok.Value;
import com.salesianos.triana.finalProyect.model.UserEntity;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotBlank;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import static javax.persistence.FetchType.LAZY;
import static javax.persistence.GenerationType.IDENTITY;

@Value
@Builder
public class CreateSubPostDto {

    private String imagen;

    private UUID id;

    private String nombre;

    private String descripcion;

    private List<Post> posts;

    private LocalDateTime createdDate;

    private UserEntity userEntity;

}




