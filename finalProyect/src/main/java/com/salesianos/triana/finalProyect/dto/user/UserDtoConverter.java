package com.salesianos.triana.finalProyect.dto.user;

import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.post.GetPostDto2;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.model.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserDtoConverter {
    public GetUserDto2 convertUserEntityToGetUserDto(UserEntity user) {
        return GetUserDto2.builder()
                .userId(user.getUserId())
                .email(user.getEmail())
                .username(user.getUsername())
                .avatar(user.getAvatar())
                .created(user.getCreated())
                .userId(user.getUserId())
                .postList(user.getPosts())
                .userRole(user.getUserRole())
                .build();
    }
    public GetUserDto convertUserEntityToGetUserDto2(UserEntity user) {
        return GetUserDto.builder()
                .userId(user.getUserId())
                .email(user.getEmail())
                .username(user.getUsername())
                .avatar(user.getAvatar())
                .created(user.getCreated())
                .userId(user.getUserId())
                .postList(user.getPosts().stream().map(p -> new GetPostDto(p.getImagenportada(), p.getPostId(),p.getDescription() , p.getPostName() ,p.getUserEntity().getUserId(), p.getCreatedDate() , p.getSubposts().getNombre())).toList())
                .userRole(user.getUserRole())
                .build();
    }

}



