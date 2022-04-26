package com.salesianos.triana.finalProyect.service;

import com.salesianos.triana.finalProyect.dto.post.GetPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.SubPostDtoConverter;
import com.salesianos.triana.finalProyect.exception.*;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.SubPosts;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;
import io.github.techgnious.exception.VideoException;
import lombok.RequiredArgsConstructor;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;

import javax.imageio.ImageIO;
import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class SubPostsService {

    private final SubPostsRepository subPostsRepository;
    private final StorageService storageService;
    private final SubPostDtoConverter subPostDtoConverter;
    private final UserEntityRepository userEntityRepository;

    public SubPosts save(CreateSubPostDto createSubPostDto, MultipartFile file, UserEntity user) throws IOException, VideoException {

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

        SubPosts post3 = SubPosts.builder()
                .id(createSubPostDto.getId())
                .createdDate(createSubPostDto.getCreatedDate())
                .userEntity(user)
                .nombre(createSubPostDto.getNombre())
                .imagen(uri)
                .descripcion(createSubPostDto.getDescripcion())
                .posts(createSubPostDto.getPosts())
                .build();

        return subPostsRepository.save(post3);
    }


    public ResponseEntity deleteSubPost(UserEntity user, Long id) throws IOException {
        Optional<SubPosts> subpost = subPostsRepository.findById(id);
        if (subpost.isEmpty()) {
            throw new SingleEntityNotFoundException(id.toString(), Post.class);
        } else {
            if (subpost.get().getUserEntity().getUsername().equals(user.getUsername())) {
                String scale = StringUtils.cleanPath(String.valueOf(subpost.get().getImagenEscalada())).replace("http://localhost:8080/download/", "")
                        .replace("%20", " ");
                Path path = storageService.load(scale);
                String filename = StringUtils.cleanPath(String.valueOf(path)).replace("http://localhost:8080/download/", "")
                        .replace("%20", " ");
                Path pathScalse = Paths.get(filename);
                storageService.deleteFile(pathScalse);

                String original = StringUtils.cleanPath(String.valueOf(subpost.get().getImagen())).replace("http://localhost:8080/download/", "")
                        .replace("%20", " ");
                Path path2 = storageService.load(original);
                String filename2 = StringUtils.cleanPath(String.valueOf(path2)).replace("http://localhost:8080/download/", "")
                        .replace("%20", " ");
                Path pathOriginal = Paths.get(filename2);
                storageService.deleteFile(pathOriginal);

                subPostsRepository.deleteById(id);

                return ResponseEntity.noContent().build();
            } else {
                throw new DynamicException("No eres propietario de este subpost");
            }


        }
    }

    public SubPosts editSubPost(CreateSubPostDto newPost, MultipartFile file, UserEntity user, Long id) throws IOException, VideoException {


        Optional<SubPosts> subpost = subPostsRepository.findById(id);

        if (subpost.isEmpty()) {
            throw new SingleEntityNotFoundException(id.toString(), Post.class);
        } else {
            if (subpost.get().getUserEntity().getUsername().equals(user.getUsername())) {
                subpost.get().setDescripcion(newPost.getDescripcion());
                subpost.get().setNombre(newPost.getNombre());
                subpost.get().setImagenEscalada(newPost.getImagenEscalada());


                String videoExtension = "mp4";
                String extension = StringUtils.getFilenameExtension(StringUtils.cleanPath(file.getOriginalFilename()));
                List<String> allExtension = Arrays.asList("png", "gif", "jpg", "svg", "mp4");

                if (!allExtension.contains(extension)) {
                    throw new UnsupportedMediaType(allExtension);
                } else {
                    String scale = StringUtils.cleanPath(String.valueOf(subpost.get().getImagenEscalada())).replace("http://localhost:8080/download/", "")
                            .replace("%20", " ");
                    Path path = storageService.load(scale);
                    String filename = StringUtils.cleanPath(String.valueOf(path)).replace("http://localhost:8080/download/", "")
                            .replace("%20", " ");
                    Path pathScalse = Paths.get(filename);
                    storageService.deleteFile(pathScalse);


                    String original = StringUtils.cleanPath(String.valueOf(subpost.get().getImagen())).replace("http://localhost:8080/download/", "")
                            .replace("%20", " ");
                    Path path2 = storageService.load(original);
                    String filename2 = StringUtils.cleanPath(String.valueOf(path2)).replace("http://localhost:8080/download/", "")
                            .replace("%20", " ");
                    Path pathOriginal = Paths.get(filename2);
                    storageService.deleteFile(pathOriginal);


                    String filenameOriginal = storageService.original(file);
                    String filenamePublicacion;
                    if (!videoExtension.contains(extension)) {
                        filenamePublicacion = storageService.escalado(file, 1024);

                    } else {
                        filenamePublicacion = storageService.videoEscalado(file);
                    }

                    String urinew = ServletUriComponentsBuilder.fromCurrentContextPath()
                            .path("/download/")
                            .path(filenamePublicacion)
                            .toUriString();

                    String uriOld = ServletUriComponentsBuilder.fromCurrentContextPath()
                            .path("/download/")
                            .path(filenameOriginal)
                            .toUriString();

                    subpost.get().setImagen(uriOld);
                    subpost.get().setImagenEscalada(urinew);

                }
            } else {
                throw new DynamicException("No eres propietario de este post");
            }

            return subPostsRepository.save(subpost.get());
        }
    }
}
/*
    public List<GetSubPostDto> getAllSubpost(UserEntity user) throws IOException {
        Optional<SubPosts> subPostsList = userEntityRepository.getById(user.getUserId());
        if (subPostsList.isEmpty()) {
            throw new ListEntityNotFoundException(SubPosts.class);
        } else {
            List<GetSubPostDto> getSubPostDto = subPostsList.stream().map(p -> new GetSubPostDto(
                    p.getImagen(),
                    p.getId(),
                    p.getNombre(),
                    p.getDescripcion(),
                    p.getCreatedDate(),
                    p.getUserEntity().getUserId()
            )).toList();
            return getSubPostDto;
        }

    }
    }

    public List<GetSubPostDto> findByPostSubPost(SubPosts subreddit) {

        List<SubPosts> listaa = subPostsRepository.findAllBySubposts(subreddit);

       return listaa.stream().map(subPostDtoConverter::subPostToGetSubPostDto).toList();
    }



    }
*/


