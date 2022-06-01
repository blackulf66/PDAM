package com.salesianos.triana.finalProyect.repository;

import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPost;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PostRepository extends JpaRepository<Post, Long> {

    Optional<Post> findById(Long id);

    Post findByPostName(String postName);

    List<Post> findByUserEntity(UserEntity user);

    List<Post> findAllBySubposts(SubPost subPosts);



}
