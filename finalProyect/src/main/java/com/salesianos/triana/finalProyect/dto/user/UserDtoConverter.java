package com.salesianos.triana.finalProyect.dto.user;

import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.stereotype.Component;

@Component
public class UserDtoConverter {
    public GetUserDto convertUserEntityToGetUserDto(UserEntity user) {
        return GetUserDto.builder()
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

}

