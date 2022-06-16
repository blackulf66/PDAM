package com.salesianos.triana.finalProyect.repository;

import com.salesianos.triana.finalProyect.model.SubPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SubPostsRepository extends JpaRepository<SubPost, Long> {

    Optional<SubPost> findById(Long id);

    SubPost findByNombre(String nombre);

    boolean existsByNombre(String nombre);




}
