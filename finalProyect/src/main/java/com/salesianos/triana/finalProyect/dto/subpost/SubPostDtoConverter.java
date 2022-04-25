package com.salesianos.triana.finalProyect.dto.subpost;

import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
public class SubPostDtoConverter {
    private final UserEntityRepository userEntityRepository;

    public CreateSubPostDto createPostDtoToPost(CreateSubPostDto c){
        return CreateSubPostDto.builder()
                .id(c.getId())
                .nombre(c.getNombre())
                .userEntityId(c.getUserEntityId())
                .createdDate(c.getCreatedDate())
                .descripcion(c.getDescripcion())
                .imagen(c.getImagen())
                .posts(c.getPosts())
                .build();
    }

    public GetSubPostDto subPostToGetSubPostDto(SubPosts c){
        return GetSubPostDto
                .builder()
                .id(c.getId())
                .nombre(c.getNombre())
                .userEntityId(c.getUserEntity().getUserId())
                .createdDate(LocalDateTime.now())
                .descripcion(c.getDescripcion())
                .imagen(c.getImagen())
                .build();
    }

}
