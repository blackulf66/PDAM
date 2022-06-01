package com.salesianos.triana.finalProyect.dto.subpost;

import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.model.SubPost;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
public class SubPostDtoConverter {
    private final UserEntityRepository userEntityRepository;

    public CreateSubPostDto createsubPostDtoTosubPost(CreateSubPostDto c){
        return CreateSubPostDto.builder()
                .id(c.getId())
                .nombre(c.getNombre())
                .userEntityId(c.getUserEntityId())
                .createdDate(c.getCreatedDate())
                .descripcion(c.getDescripcion())
                .imagen(c.getImagenEscalada())
                .posts(c.getPosts())
                .build();
    }

    public GetSubPostDto subPostToGetSubPostDto(SubPost c){
        return GetSubPostDto
                .builder()
                .id(c.getId())
                .nombre(c.getNombre())
                .userEntityId(c.getUserEntity().getUserId())
                .createdDate(LocalDateTime.now())
                .descripcion(c.getDescripcion())
                .postList(c.getPosts())
                .imagen(c.getImagen())
                .build();
    }

    public GetSubPostDto3 subPostToGetSubPostDto1(SubPost c){
        return GetSubPostDto3
                .builder()
                .id(c.getId())
                .nombre(c.getNombre())
                .userEntityId(c.getUserEntity().getUserId())
                .createdDate(LocalDateTime.now())
                .descripcion(c.getDescripcion())
                .imagen(c.getImagen())
                .build();
    }



    public GetSubPostDto2 subPostToGetSubPostDto2(SubPost c){
        return GetSubPostDto2
                .builder()
                .id(c.getId())
                .nombre(c.getNombre())
                .userEntityId(c.getUserEntity().getUserId())
                .createdDate(LocalDateTime.now())
                .descripcion(c.getDescripcion())
                .postList(c.getPosts().stream().map(p -> new GetPostDto(p.getImagenportada(), p.getPostId(), p.getPostName(),p.getDescription(),p.getUserEntity().getUserId(),p.getCreatedDate(),p.getSubposts().getNombre(),p.getVoteCount())).toList())
                .imagen(c.getImagen())
                .build();
    }

}
