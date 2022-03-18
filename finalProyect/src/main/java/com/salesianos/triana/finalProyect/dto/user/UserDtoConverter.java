package com.salesianos.triana.finalProyect.dto.user;

import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.stereotype.Component;

@Component
public class UserDtoConverter {
    public GetUserDto convertUserEntityToGetUserDto(UserEntity user) {
        return GetUserDto.builder()
                .email(user.getEmail())
                .avatar(user.getAvatar())
                .created(user.getCreated())
                .password(user.getPassword())
                .userId(user.getUserId())
                .subpostList(user.getSubposts())
                .build();

    }

}

