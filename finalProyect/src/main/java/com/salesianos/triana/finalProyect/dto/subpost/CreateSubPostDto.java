package com.salesianos.triana.finalProyect.dto.subpost;

import com.salesianos.triana.finalProyect.model.Post;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateSubPostDto {

    private String imagen;

    private String imagenEscalada;

    private Long id;

    private String nombre;

    private String descripcion;

    private List<Post> posts;

    private LocalDateTime createdDate;

    private UUID userEntityId;

}




