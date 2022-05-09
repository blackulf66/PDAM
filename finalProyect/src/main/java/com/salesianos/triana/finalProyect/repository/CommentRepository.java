package com.salesianos.triana.finalProyect.repository;

import com.salesianos.triana.finalProyect.model.Comment;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    List<Comment> findByPost(Post post);

    List<Comment> findAllByUserEntity(UserEntity userEntity);
}