package com.salesianos.triana.finalProyect.repository;

import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPost;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {
    @Override
    /*@Query(
            """
             select u
             from UserEntity u
             join fetch u.Subposts
             where u.userId = id
             """
    )*/
    Optional<UserEntity> findById(UUID id);

    Optional<UserEntity> findByUsername(String username);

    Optional<UserEntity> findByEmail(String email);

    /*@Query(
            """
             select u
             from UserEntity u
             join fetch u.posts
             where u.userId = id       
             """
    )*/

    Optional<UserEntity> findFirstByEmail(String email);

    boolean existsByEmail(String email);

    @Query(
            """
            select u.subPostsList
            from UserEntity u
            where u.id = :id
            """
    )
    List<SubPost> findAllSubpost(@Param("id") UUID id);


    @Query(
            """
            select u.posts
            from UserEntity u
            where u.id = :id
            """
    )
    List<Post> findAllPost(@Param("id") UUID id);
}

