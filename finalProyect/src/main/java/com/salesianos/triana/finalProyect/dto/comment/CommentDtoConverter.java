package com.salesianos.triana.finalProyect.dto.comment;


import com.salesianos.triana.finalProyect.dto.post.CreatePostDto;
import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.model.Comment;
import com.salesianos.triana.finalProyect.model.Post;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.Instant;

@Component
@RequiredArgsConstructor
public class CommentDtoConverter {

    public CreateCommentDto commentDtoToComment(Comment c){
        return CreateCommentDto.builder()
                .id(c.getId())
                .postId(c.getPost().getPostId())
                .createdDate(Instant.now())
                .text(c.getText())
                .userName(c.getUserEntity().getUsername())
                .build();
    }

    public GetCommentDto commentToGetcommentDto(Comment c){
        return GetCommentDto
                .builder()
                .id(c.getId())
                .postId(c.getPost().getPostId())
                .createdDate(Instant.now())
                .text(c.getText())
                .userName(c.getUserEntity().getUsername())
                .build();
    }
}
