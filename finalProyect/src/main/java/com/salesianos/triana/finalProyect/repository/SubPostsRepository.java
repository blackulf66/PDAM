package com.salesianos.triana.finalProyect.repository;

import com.salesianos.triana.finalProyect.model.SubPosts;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SubPostsRepository extends JpaRepository<SubPosts, Long> {

    Optional<SubPosts> findById(Long id);

    SubPosts findByNombre(String nombre);

    boolean existsByNombre(String nombre);




}
