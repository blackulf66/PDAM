package com.salesianos.triana.finalProyect.model;

import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.transaction.Transactional;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;
import java.util.*;

import static javax.persistence.FetchType.EAGER;
import static javax.persistence.FetchType.LAZY;

@Data
@EntityListeners(AuditingEntityListener.class)
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name="user")
public class UserEntity implements UserDetails {
    @Id
    @GeneratedValue
    private UUID userId;

    @NotBlank(message = "Username is required")
    private String username;

    @NotBlank(message = "Password is required")
    private String password;

    @Email
    @NotEmpty(message = "Email is required")
    private String email;

    private String avatar;

    private LocalDateTime created;

    @OneToMany(fetch = LAZY,cascade = CascadeType.ALL)
    @JoinColumn(name = "postid")
    private List<Post> posts;

    @OneToMany(fetch = EAGER ,cascade = CascadeType.ALL)
    @JoinColumn(name = "subpostid")
    private List<SubPosts> Subposts;

    private UserRole userRole;

    //Helpers

    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    public String getUsername() {
        return username;
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

    public Collection<SubPosts> getSubPost() {
        return Subposts;
    }


}
