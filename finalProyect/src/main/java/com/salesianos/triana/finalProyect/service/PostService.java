package com.salesianos.triana.finalProyect.service;

import com.salesianos.triana.finalProyect.dto.post.CreatePostDto;
import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.post.PostDtoConverter;
import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.exception.SinComunidadException;
import com.salesianos.triana.finalProyect.exception.SingleEntityNotFoundException;
import com.salesianos.triana.finalProyect.exception.UnsupportedMediaType;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.repository.PostRepository;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;
import io.github.techgnious.exception.VideoException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.transaction.Transactional;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static java.util.stream.Collectors.toList;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;
    private final StorageService storageService;
    private final SubPostsRepository subPostsRepository;
    private final PostDtoConverter postDtoConverter;
    private final UserEntityRepository userEntityRepository;

    public Post save(CreatePostDto createPostDto, MultipartFile file, UserEntity user, String postName) throws IOException, VideoException, SinComunidadException {

        String filenameOriginal = storageService.original(file);

        SubPosts data = subPostsRepository.findByNombre(postName);

        String videoExtension = "mp4";

        String extension = StringUtils.getFilenameExtension(StringUtils.cleanPath(file.getOriginalFilename()));
        List<String> imagenExtension = Arrays.asList("png", "gif", "jpg", "svg");
        String filenamePublicacion;
        List<String> allExtension = Arrays.asList("png", "gif", "jpg", "svg", "mp4");


        if (imagenExtension.contains(extension)) {
            filenamePublicacion = storageService.escalado(file, 1024);

        } else if (videoExtension.equals(extension)) {
            filenamePublicacion = storageService.videoEscalado(file);
        } else {

            throw new UnsupportedMediaType(allExtension);
        }


        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(filenamePublicacion)
                .toUriString()
                .replace("10.0.2.2", "localhost");

        String uriOriginal = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(filenameOriginal)
                .toUriString()
                .replace("10.0.2.2", "localhost");

        if(data == null){
            throw new SinComunidadException("no hay comunidades");
        }else{
            Post post = Post.builder()
                    .postId(createPostDto.getPostId())
                    .postName(createPostDto.getPostName())
                    .createdDate(Instant.now())
                    .userEntity(user)
                    .subposts(data)
                    .imagenportada(uri)
                    .description(createPostDto.getDescription())
                    .voteCount(0)
                    .build();

            return postRepository.save(post);
        }

    }
    public void deletePost(Long id) throws IOException {

        try {
            Optional<Post> post = postRepository.findById(id);
            if (post.isPresent()) {

                storageService.deleteFile2(post.get().getImagenportada());
                postRepository.delete(post.get());
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }


    }

    public Optional<Post> findById(Long id) {
        return postRepository.findById(id);
    }

    public GetPostDto findOnePost(String postName, UserEntity user) {

        Post post =postRepository.findByPostName(postName);

        if (post == null) {
            throw new SingleEntityNotFoundException(postName, SubPosts.class);
        } else {
            return postDtoConverter.PostToGetPostDto(post);
        }
    }


    @Transactional()
    public List<GetPostDto> getAllPosts() {
        return postRepository.findAll()
                .stream()
                .map(postDtoConverter::PostToGetPostDto)
                .collect(toList());
    }
    @Transactional()
    public List<GetPostDto> getPostsBysubpost(Long subpostid) {
        SubPosts subposts = subPostsRepository.findById(subpostid)
                .orElseThrow(() -> new com.salesianos.triana.finalProyect.exception.FileNotFoundException(subpostid.toString()));
        List<Post> posts = postRepository.findAllBySubposts(subposts);
        return posts.stream().map(postDtoConverter::PostToGetPostDto).collect(toList());
    }

    public Optional<GetPostDto> updatePost(Long id, CreatePostDto p, MultipartFile file, UserEntity user) throws Exception {

        Optional<Post> data = postRepository.findById(id);

        if (data.isPresent()) {


            List<String> videoExtension = Arrays.asList("webm", "mkv", "flv", "vob", "ogv", "ogg",
                    "rrc", "gifv", "mng", "mov", "avi", "qt", "wmv", "yuv", "rm", "asf", "amv", "mp4", "m4p", "m4v", "mpg", "mp2", "mpeg", "mpe",
                    "mpv", "m4v", "svi", "3gp", "3gpp", "3g2", "mxf", "roq", "nsv", "flv", "f4v", "f4p", "f4a", "f4b", "mod");

            String name = StringUtils.cleanPath(file.getOriginalFilename());

            String extension = StringUtils.getFilenameExtension(name);

            if (data.get().getUserEntity().getUsername().equals(user.getUsername())) {

                if (file.isEmpty()) {

                    return data.map(m -> {
                        m.setPostName(p.getPostName());
                        m.setDescription(p.getDescription());
                        m.setSubposts(p.getSubPosts());
                        m.setCreatedDate(Instant.now());
                        m.setImagenportada(m.getImagenportada());
                        postRepository.save(m);
                        return postDtoConverter.PostToGetPostDto(m);
                    });

                } else if (!videoExtension.contains(extension)) {


                    String name2 = StringUtils.cleanPath(String.valueOf(data.get().getImagenportada())).replace("http://localhost:8080/download/", "")
                            .replace("%20", " ");

                    Path pa = storageService.load(name2);

                    String filename = StringUtils.cleanPath(String.valueOf(pa)).replace("http://localhost:8080/download/", "")
                            .replace("%20", " ");

                    Path path = Paths.get(filename);

                    storageService.deleteFile(path);

                    String original = storageService.original(file);
                    String newFilename = storageService.escalado(file, 1024);

                    String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                            .path("/download/")
                            .path(newFilename)
                            .toUriString();

                    return data.map(m -> {
                        m.setPostName(p.getPostName());
                        m.setDescription(p.getDescription());
                        m.setSubposts(p.getSubPosts());
                        m.setCreatedDate(Instant.now());
                        m.setImagenportada(m.getImagenportada());
                        postRepository.save(m);
                        return postDtoConverter.PostToGetPostDto(m);
                    });

                } else {

                    String name2 = StringUtils.cleanPath(String.valueOf(data.get().getImagenportada())).replace("http://localhost:8080/download/", "")
                            .replace("%20", " ");

                    Path pa = storageService.load(name2);

                    String filename = StringUtils.cleanPath(String.valueOf(pa)).replace("http://localhost:8080/download/", "")
                            .replace("%20", " ");

                    Path path = Paths.get(filename);

                    storageService.deleteFile(path);

                    String original = storageService.original(file);
                    String newFilename = storageService.escalado(file, 1024);

                    String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                            .path("/download/")
                            .path(newFilename)
                            .toUriString();

                    return data.map(m -> {
                        m.setPostName(p.getPostName());
                        m.setDescription(p.getDescription());
                        m.setSubposts(p.getSubPosts());
                        m.setCreatedDate(Instant.now());
                        m.setImagenportada(m.getImagenportada());
                        postRepository.save(m);
                        return postDtoConverter.PostToGetPostDto(m);
                    });
                }
            } else {
                throw new FileNotFoundException("No eres el propietario de esta publicación");
            }

        } else {
            throw new SingleEntityNotFoundException(id.toString(), SubPosts.class);
        }
    }

}
