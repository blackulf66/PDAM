package dto.post;

import com.salesianostriana.dam.model.PostEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import model.UserEntity;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetPostDto {
    private Long id;

    private String titulo,noticia;

    private String imagen;

    private String categoria;

    private UserEntity user;






}
