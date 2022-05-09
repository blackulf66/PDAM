package com.salesianos.triana.finalProyect.service;


import com.salesianos.triana.finalProyect.dto.comment.CommentDtoConverter;
import com.salesianos.triana.finalProyect.dto.comment.CreateCommentDto;
import com.salesianos.triana.finalProyect.dto.comment.GetCommentDto;
import com.salesianos.triana.finalProyect.exception.FileNotFoundException;
import com.salesianos.triana.finalProyect.exception.UnsupportedMediaType;
import com.salesianos.triana.finalProyect.model.Comment;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.repository.CommentRepository;
import com.salesianos.triana.finalProyect.repository.PostRepository;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;
import lombok.AllArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import static java.util.stream.Collectors.toList;

@Service
@AllArgsConstructor
public class CommentService {
    private static final String POST_URL = "";
    private final PostRepository postRepository;
    private final UserEntityRepository userRepository;
    private final CommentRepository commentRepository;
    private final UserEntityService userEntityService;
    private final CommentDtoConverter commentDtoConverter;

    public Comment save(CreateCommentDto newcomment, UserEntity user ,Post post) {

            Comment comment = Comment.builder()
                    .id(newcomment.getId())
                    .createdDate(Instant.now())
                    .text(newcomment.getText())
                    .userEntity(user)
                    .post(post)
                    .build();

            return commentRepository.save(comment);

    }



    public List<CreateCommentDto> getAllCommentsForPost(Long postId) {
        Post post = postRepository.findById(postId).orElseThrow(() -> new FileNotFoundException(postId.toString()));

        return commentRepository.findByPost(post)
                .stream()
                .map(commentDtoConverter::commentDtoToComment)
                .collect(toList());
    }

    public List<CreateCommentDto> getAllCommentsForUser(String userName) {
        UserEntity user = userRepository.findByUsername(userName)
                .orElseThrow(() -> new UsernameNotFoundException(userName));
        return commentRepository.findAllByUserEntity(user)
                .stream()
                .map(commentDtoConverter::commentDtoToComment)
                .collect(toList());
    }

}