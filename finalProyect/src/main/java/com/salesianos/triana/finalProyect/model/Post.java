package com.salesianos.triana.finalProyect.model;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.lang.Nullable;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.time.Instant;

import static javax.persistence.FetchType.LAZY;
import static javax.persistence.GenerationType.IDENTITY;


@Data
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Post")

public class Post {

    private String imagenportada;
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long postId;

    @NotBlank(message = "el nombre de un post no puede ser nulo")
    private String postName;

    @Nullable
    @Lob
    private String description;

    private Integer voteCount = 0;

    @ManyToOne(fetch = LAZY)
    private UserEntity userEntity;

    private Instant createdDate;

    @ManyToOne(fetch = LAZY)
    private SubPosts subposts;

    //helpers

    public void addToUsuario(UserEntity u){
        this.userEntity = u;
        u.getPosts().add(this);
    }

    public void removeFromUsuario(UserEntity u){
        u.getPosts().remove(this);
        this.userEntity = null;
    }
}