package com.salesianos.triana.finalProyect.dto.user;

import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.post.GetPostDto2;
import com.salesianos.triana.finalProyect.dto.post.PostDtoConverter;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class UserDtoConverter {

    private final UserEntityRepository userEntityRepository;
    private final PostDtoConverter postDtoConverter;


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
                .following(user.getSubPostsList())
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
                .postList(userEntityRepository.findAllPost(user.getUserId()).stream().map(postDtoConverter::PostToGetPostDto).collect(Collectors.toList()))
                /*

                .postList(user.getPosts().stream().map(p -> new GetPostDto(p.getImagenportada(), p.getPostId(),p.getDescription() , p.getPostName() ,p.getUserEntity().getUserId(), p.getCreatedDate() , p.getSubposts().getNombre(), p.getVoteCount())).toList())
                 */
                .userRole(user.getUserRole())
                .following(userEntityRepository.findAllSubpost(user.getUserId()))
                .build();
    }

}



