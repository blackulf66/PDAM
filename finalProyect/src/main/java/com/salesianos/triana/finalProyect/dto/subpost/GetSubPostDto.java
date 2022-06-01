package com.salesianos.triana.finalProyect.dto.subpost;

import com.salesianos.triana.finalProyect.model.Post;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetSubPostDto {

    private String imagen;

    private Long id;

    private String nombre;

    private String descripcion;

    private LocalDateTime createdDate;

    private List<Post> postList;

    private UUID userEntityId;

}






