package security.dto;

import com.salesianostriana.dam.dto.post.GetPostDto;
import dto.post.GetPostDto;
import lombok.*;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class JwtUserResponse {

    private String email;
    private String nick;
    private String avatar;
    private String username;
    private String role;
    private String token;
    private Date fecha;
    private List<GetPostDto> posts;

}