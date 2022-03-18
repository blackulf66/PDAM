package dto.user;


import com.salesianostriana.dam.model.Post;
import com.salesianostriana.dam.users.models.UserEntity;
import lombok.*;
import model.Post;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateUserDto {

    private String username;

    private String password;

    private String email;

    private String avatar;

    private Instant created;


}
