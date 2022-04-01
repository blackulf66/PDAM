package com.salesianos.triana.finalProyect.dto.subpost;

import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import org.springframework.stereotype.Component;

@Component
public class SubPostDtoConverter {
    public CreateSubPostDto createPostDtoToPost(CreateSubPostDto c){
        return CreateSubPostDto.builder()
                .id(c.getId())
                .nombre(c.getNombre())
                .userEntity(c.getUserEntity())
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
                .userEntity(c.getUserEntity())
                .createdDate(c.getCreatedDate())
                .descripcion(c.getDescripcion())
                .imagen(c.getImagen())
                .posts(c.getPosts())
                .build();
    }

}
