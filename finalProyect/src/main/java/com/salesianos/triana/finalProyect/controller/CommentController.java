package com.salesianos.triana.finalProyect.controller;

import com.salesianos.triana.finalProyect.dto.comment.CreateCommentDto;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.service.CommentService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.http.HttpStatus.CREATED;
import static org.springframework.http.HttpStatus.OK;

@RestController
@RequestMapping("/api/comments")
@AllArgsConstructor
public class CommentController {
    private final CommentService commentService;

    @PostMapping("/")
    public ResponseEntity<Void> createComment(@RequestBody CreateCommentDto commentsDto, @AuthenticationPrincipal UserEntity user , @RequestBody Post post) {
        commentService.save(commentsDto , user, post);
        return new ResponseEntity<>(CREATED);
    }

    @GetMapping("/by-post/{postId}")
    public ResponseEntity<List<CreateCommentDto>> getAllCommentsForPost(@PathVariable Long postId) {
        return ResponseEntity.status(OK)
                .body(commentService.getAllCommentsForPost(postId));
    }

    @GetMapping("/by-user/{userName}")
    public ResponseEntity<List<CreateCommentDto>> getAllCommentsForUser(@PathVariable String userName){
        return ResponseEntity.status(OK)
                .body(commentService.getAllCommentsForUser(userName));
    }

}