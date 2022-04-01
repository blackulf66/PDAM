package com.salesianos.triana.finalProyect.dto.subpost;

import com.salesianos.triana.finalProyect.model.Post;
import org.springframework.stereotype.Component;

@Component
public class SubPostDtoConverter {
    public CreatesubPostDto createPostDtoToPost(CreatesubPostDto c){
        return CreatesubPostDto.builder()
                .postId(c.getPostId())
                .postName(c.getPostName())
                .description(c.getDescription())
                .createdDate(c.getCreatedDate())
                .userEntity(c.getUserEntity())
                .subposts(c.getSubposts())
                .imagenPortada(c.getImagenPortada())
                .build();
    }

    public GetSubPostDto postToGetPostDto(Post c){
        return GetSubPostDto
                .builder()
                .postId(c.getPostId())
                .postName(c.getPostName())
                .description(c.getDescription())
                .createdDate(c.getCreatedDate())
                .userEntity(c.getUserEntity())
                .subposts(c.getSubposts())
                .imagenPortada(c.getImagenportada())
                .build();
    }

}
