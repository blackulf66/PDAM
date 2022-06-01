package com.salesianos.triana.finalProyect.model;

import com.salesianos.triana.finalProyect.validadores.UniqueEmail;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.hibernate.annotations.Parameter;

import javax.persistence.*;
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
@Table(name="userEntity")
public class UserEntity implements UserDetails {
    @GeneratedValue
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    @Type(type="uuid-char")
    @Id
    private UUID userId;

    @NotBlank(message = "Username is required")
    private String username;

    @NotBlank(message = "Password is required")
    private String password;

    @Email
    @NotEmpty(message = "Email is required")
    @UniqueEmail(message ="{email.nombre.unico}")
    @Column(unique = true)
    private String email;

    private String avatar;

    private LocalDateTime created;

    @OneToMany(fetch = EAGER,cascade = CascadeType.ALL, mappedBy = "userEntity")
    @Builder.Default
    private List<Post> posts = new ArrayList<>();

    @OneToMany(fetch = LAZY ,cascade = CascadeType.ALL , mappedBy = "userEntity")
    @Builder.Default
    private List<SubPost> Subposts= new ArrayList<>();

    private UserRole userRole;

    @ManyToMany
    @JoinTable(
            name="tabla_join",
            joinColumns= @JoinColumn(name="userId"),
            inverseJoinColumns=@JoinColumn(name="subpostid")
    )
    private List<SubPost> subPostsList = new ArrayList<>();

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

    public Collection<SubPost> getSubPost() {
        return Subposts;
    }


}
