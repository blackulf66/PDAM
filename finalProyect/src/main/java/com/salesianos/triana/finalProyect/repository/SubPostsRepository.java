package com.salesianos.triana.finalProyect.repository;

import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SubPostsRepository extends JpaRepository<Post, Long> {

    Optional<SubPosts> findByPostName(String subredditName);




}
