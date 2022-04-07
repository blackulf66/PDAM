package com.salesianos.triana.finalProyect.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import static javax.persistence.FetchType.LAZY;
import static javax.persistence.GenerationType.IDENTITY;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "SubPost")
@Builder
public class SubPosts {

    private String imagen;
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "subpostid")
    private UUID id;

    @NotBlank(message = "el nombre del subpost es necesario")
    private String nombre;

    private String descripcion;

    @OneToMany(fetch = LAZY)
    private List<Post> posts;

    private LocalDateTime createdDate;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userId")
    private UserEntity userEntity;

    //helpers

    public void addToUser(UserEntity u){
        this.userEntity = u;
        u.getSubposts().add(this);
    }

    public void removeFromUser(UserEntity u){
        u.getSubposts().remove(this);
        this.userEntity = null;
    }

}