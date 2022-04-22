package com.salesianos.triana.finalProyect.dto.post;

import com.salesianos.triana.finalProyect.model.Post;
import org.springframework.stereotype.Component;

@Component
public class PostDtoConverter {
    public CreatePostDto createPostDtoToPost(CreatePostDto c){
        return CreatePostDto.builder()
                .postId(c.getPostId())
                .postName(c.getPostName())
                .description(c.getDescription())
                .createdDate(c.getCreatedDate())
                .userEntity(c.getUserEntity())
                .subposts(c.getSubposts())
                .imagenPortada(c.getImagenPortada())
                .build();
    }

    public GetPostDto postToGetPostDto(Post c){
        return GetPostDto
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
