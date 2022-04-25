package com.salesianos.triana.finalProyect.repository;

import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface SubPostsRepository extends JpaRepository<SubPosts, Long> {

    Optional<SubPosts> findById(UUID id);

}
