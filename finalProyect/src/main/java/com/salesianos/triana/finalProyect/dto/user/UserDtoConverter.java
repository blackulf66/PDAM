package com.salesianos.triana.finalProyect.dto.user;

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
                .subpostList(user.getSubposts())
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
                .subpostList(user.getSubposts().stream().map(p -> new GetSubPostDto(p.getImagen(), p.getId(), p.getNombre() , p.getDescripcion() ,p.getCreatedDate() , p.getUserEntity().getUserId())).toList())
                .userRole(user.getUserRole())
                .build();
    }

}



