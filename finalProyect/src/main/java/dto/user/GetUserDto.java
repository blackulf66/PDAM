package dto.user;

import lombok.*;
import model.Post;
import model.UserEntity;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetUserDto {

    private Long userId;

    private String username;

    private String password;

    private String email;

    private String avatar;

    private Instant created;


}
