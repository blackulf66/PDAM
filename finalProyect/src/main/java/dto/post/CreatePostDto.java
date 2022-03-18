package dto.post;

import com.salesianostriana.dam.model.PostEnum;
import lombok.Builder;
import lombok.Value;
import model.UserEntity;

@Value
@Builder
public class CreatePostDto {

    private Long id;

    private String titulo,noticia;

    private String imagen;

    private String categoria;

    private UserEntity user;




}
