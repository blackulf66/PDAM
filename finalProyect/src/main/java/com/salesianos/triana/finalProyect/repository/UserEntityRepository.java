package com.salesianos.triana.finalProyect.repository;

import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {
    @Override
    @Query(
            """
             select u
             from UserEntity u
             join fetch u.Subposts
             where u.userId = id       
             """
    )
    Optional<UserEntity> findById(UUID id);

    Optional<UserEntity> findByUsername(String username);
    /*@Query(
            """
             select u
             from UserEntity u
             join fetch u.posts
             where u.userId = id       
             """
    )*/

    Optional<UserEntity> findFirstByEmail(String email);
}

