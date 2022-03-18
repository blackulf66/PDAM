package com.salesianos.triana.finalProyect.model;

import lombok.*;
import org.springframework.security.core.GrantedAuthority;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.time.Instant;
import java.time.LocalDate;
import java.util.*;

import static javax.persistence.FetchType.LAZY;
import static javax.persistence.GenerationType.IDENTITY;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
public class UserEntity {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private UUID userId;

    @NotBlank(message = "Username is required")
    private String username;

    @NotBlank(message = "Password is required")
    private String password;

    @Email
    @NotEmpty(message = "Email is required")
    private String email;

    private String avatar;

    private Instant created;

    @OneToMany(fetch = LAZY)
    private List<Post> posts;

    @OneToMany(fetch = LAZY)
    private List<SubPosts> Subposts;



    //Helpers

    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    public String getUsername() {
        return email;
    }

    public boolean isAccountNonExpired() {
        return true;
    }

    public boolean isAccountNonLocked() {
        return true;
    }

    public boolean isCredentialsNonExpired() {
        return true;
    }

    public boolean isEnabled() {
        return true;
    }
}
