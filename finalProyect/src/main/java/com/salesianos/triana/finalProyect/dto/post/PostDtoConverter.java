package com.salesianos.triana.finalProyect.dto.post;

import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.model.Post;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import java.time.Instant;

@Component
@RequiredArgsConstructor
public class PostDtoConverter {

    public CreatePostDto PostDtoToPost(Post c){
        return CreatePostDto.builder()
                .postId(c.getPostId())
                .createdDate(Instant.now())
                .description(c.getDescription())
                .imagenportada(c.getImagenportada())
                .postName(c.getPostName())
                .userEntity(c.getUserEntity())
                .subPosts(c.getSubposts())
                .build();
    }

    public GetPostDto PostToGetPostDto(Post c){
        return GetPostDto
                .builder()
                .postId(c.getPostId())
                .postName(c.getPostName())
                .userEntityId(c.getUserEntity().getUserId())
                .createdDate(Instant.now())
                .description(c.getDescription())
                .imagenportada(c.getImagenportada())
                .subpostsName(c.getSubposts().getNombre())
                .build();
    }
}
