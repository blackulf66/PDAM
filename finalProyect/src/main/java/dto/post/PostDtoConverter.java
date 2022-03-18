package dto.post;

import com.salesianostriana.dam.model.Post;
import com.salesianostriana.dam.users.models.UserEntity;
import model.Post;
import org.springframework.stereotype.Component;

@Component
public class PostDtoConverter {
    public CreatePostDto createPostDtoToPost(CreatePostDto c){
        return CreatePostDto.builder()
                .id(c.getId())
                .titulo(c.getTitulo())
                .imagen(c.getImagen())
                .noticia(c.getNoticia())
                .user(c.getUser())
                .categoria(c.getCategoria())
                .build();
    }

    public GetPostDto postToGetPostDto(Post p){
        return GetPostDto
                .builder()
                .id(p.getId())
                .titulo(p.getTitulo())
                .noticia(p.getNoticia())
                .imagen(p.getImagen())
                .user(p.getUser())
                .categoria(p.getCategoria())
                .build();
    }

}
