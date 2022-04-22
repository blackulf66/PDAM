package com.salesianos.triana.finalProyect.service;

import com.salesianos.triana.finalProyect.dto.post.CreatePostDto;
import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.post.PostDtoConverter;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;
import com.salesianos.triana.finalProyect.exception.FileNotFoundException;
import lombok.RequiredArgsConstructor;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import com.salesianos.triana.finalProyect.repository.PostRepository;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;

import javax.imageio.ImageIO;
import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;
    private final StorageService storageService;
    private final PostDtoConverter postDtoConverter;
    private final UserEntityRepository userEntityRepository;
    @Transactional
    public Post save(CreatePostDto createPostDto, MultipartFile file , UserEntity user) throws IOException {

        String filenameOriginal = storageService.store(file);

        String filename = storageService.store(file);

        String extension = StringUtils.getFilenameExtension(filename);

        BufferedImage originalImage = ImageIO.read(file.getInputStream());

        BufferedImage escaledImage = storageService.simpleResizer(originalImage,1024);

        OutputStream outputStream = Files.newOutputStream(storageService.load(filename));

        OutputStream outputStream2 = Files.newOutputStream(storageService.load(filenameOriginal));

        ImageIO.write(escaledImage,extension,outputStream);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(filename)
                .toUriString();

        Post post3 = Post.builder()
                .postName(createPostDto.getPostName())
                .postId(createPostDto.getPostId())
                .createdDate(createPostDto.getCreatedDate())
                .description(createPostDto.getDescription())
                .subposts(createPostDto.getSubposts())
                .imagenportada(uri)
                .userEntity(user)
                .build();

        userEntityRepository.save(user);

        return postRepository.save(post3);
    }

    public void deletePost(Long id, UserEntity usuario) throws FileNotFoundException {

        usuario = userEntityRepository.findByUsername(usuario.getUsername()).get();
        Optional<Post> postAEliminar = postRepository.findById(id);

        if(postAEliminar.isPresent()) {
            storageService.deleteFile(postAEliminar.get().getImagenportada());
            postRepository.deleteById(id);
        }

        else if(!usuario.equals(postAEliminar.get().getUserEntity())){
            throw new FileNotFoundException("No encontrado");
        }
        else {
            throw new EntityNotFoundException("NONONONONONONONONONO");
        }

    }

    public void deletePosts(Long id){


        Optional<Post> postAEliminar = postRepository.findById(id);

        if(postAEliminar.isPresent()) {
            storageService.deleteFile(postAEliminar.get().getImagenportada());
            postRepository.deleteById(id);
        }

        else {
            throw new EntityNotFoundException("NNONONONONONONONONNO");
        }

    }
    public Optional<GetPostDto> updatePost (Long id, CreatePostDto p, MultipartFile file , UserEntity user) throws EntityNotFoundException {

            Optional<Post> data = postRepository.findById(id);
            String name = StringUtils.cleanPath(String.valueOf(data.get().getImagenportada())).replace("http://localhost:8080/download", "");
            Path pa = storageService.load(name);
            String filename = StringUtils.cleanPath(String.valueOf(pa)).replace("http://localhost:8080/download", "");
            storageService.deleteFile(filename);

            String or = storageService.storeOr(file);
            String newFilename = storageService.storePost(file);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(newFilename)
                    .toUriString();

            return data.map(m -> {
                m.setPostName(p.getPostName());
                m.setDescription(p.getDescription());
                m.setImagenportada(uri);
                postRepository.save(m);
                return postDtoConverter.postToGetPostDto(m);
            });
        }

    public List<GetPostDto> findByPostSubPost(SubPosts subreddit) {

        List<Post> listaa = postRepository.findAllBySubposts(subreddit);

       return listaa.stream().map(postDtoConverter::postToGetPostDto).toList();
    }



    }


