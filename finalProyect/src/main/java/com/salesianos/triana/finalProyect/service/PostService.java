package com.salesianos.triana.finalProyect.service;

import com.salesianos.triana.finalProyect.dto.post.CreatePostDto;
import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.exception.UnsupportedMediaType;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.repository.PostRepository;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;
import io.github.techgnious.exception.VideoException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;
    private final StorageService storageService;
    private final SubPostsRepository subPostsRepository;

    public Post save(CreatePostDto createPostDto, MultipartFile file, UserEntity user) throws IOException, VideoException {

        String filenameOriginal = storageService.original(file);

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

        Post post = Post.builder()
                .postId(createPostDto.getPostId())
                .postName(createPostDto.getPostName())
                .createdDate(createPostDto.getCreatedDate())
                .userEntity(user)
                .subposts(createPostDto.getSubPosts())
                .imagenportada(uri)
                .description(createPostDto.getDescription())
                .build();

        return postRepository.save(post);
    }
}
