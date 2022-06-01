package com.salesianos.triana.finalProyect.service;

import com.salesianos.triana.finalProyect.dto.subpost.CreateSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto;
import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto2;
import com.salesianos.triana.finalProyect.dto.subpost.SubPostDtoConverter;
import com.salesianos.triana.finalProyect.exception.*;
import com.salesianos.triana.finalProyect.model.SubPost;
import com.salesianos.triana.finalProyect.model.UserRole;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;
import io.github.techgnious.exception.VideoException;
import lombok.RequiredArgsConstructor;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;

import javax.transaction.Transactional;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static java.util.stream.Collectors.toList;

@Service
@RequiredArgsConstructor
public class SubPostsService {

    private final SubPostsRepository subPostsRepository;
    private final StorageService storageService;
    private final SubPostDtoConverter subPostDtoConverter;
    private final UserEntityRepository userEntityRepository;

    public SubPost save(CreateSubPostDto createSubPostDto, MultipartFile file, UserEntity user) throws IOException, VideoException,NotAdminException{
        if (user.getUserRole() == UserRole.ADMIN) {

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

            SubPost post3 = SubPost.builder()
                    .id(createSubPostDto.getId())
                    .createdDate(LocalDateTime.now())
                    .userEntity(user)
                    .nombre(createSubPostDto.getNombre())
                    .imagen(uri)
                    .descripcion(createSubPostDto.getDescripcion())
                    .posts(createSubPostDto.getPosts())
                    .build();

            return subPostsRepository.save(post3);
        } else {
            throw new NotAdminException("no eres admin");
        }

    }
    @Transactional()
    public List<GetSubPostDto2> getAllSubPosts() {
        return subPostsRepository.findAll()
                .stream()
                .map(subPostDtoConverter::subPostToGetSubPostDto2)
                .collect(toList());
    }



    public void deleteSubpost(Long id, UserEntity user) throws IOException {

        Optional<SubPost> data = subPostsRepository.findById(id);

        if (data.get().getUserEntity().getUsername().equals(user.getUsername())) {

            if (data.isEmpty()) {
                throw new SingleEntityNotFoundException(id.toString(), SubPost.class);
            } else {


                String name = StringUtils.cleanPath(String.valueOf(data.get().getImagen())).replace("http://localhost:8080/download/", "")
                        .replace("%20", " ");

                Path pa = storageService.load(name);

                String filename = StringUtils.cleanPath(String.valueOf(pa)).replace("http://localhost:8080/download/", "")
                        .replace("%20", " ");

                Path path = Paths.get(filename);

                storageService.deleteFile(path);

                subPostsRepository.delete(data.get());
            }

        } else {
            throw new FileNotFoundException("No es el propietario de esta publicación");
        }

    }

    public void deleteSubpost2(Long id) throws IOException {

        try {
            Optional<SubPost> post = subPostsRepository.findById(id);
            if (post.isPresent()) {

                storageService.deleteFile2(post.get().getImagen());
                subPostsRepository.delete(post.get());
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }


    }


    public Optional<SubPost> findById(Long id) {
        return subPostsRepository.findById(id);
    }

    public GetSubPostDto2 findOneSubPost(String nombre, UserEntity user) {

       SubPost subpost =subPostsRepository.findByNombre(nombre);

        if (subpost == null) {
            throw new SingleEntityNotFoundException(nombre.toString(), SubPost.class);
        } else {
            return subPostDtoConverter.subPostToGetSubPostDto2(subpost);
        }
    }

    public Optional<GetSubPostDto> updateSubPost(Long id, CreateSubPostDto p, MultipartFile file, UserEntity user) throws Exception {

        Optional<SubPost> data = subPostsRepository.findById(id);

        if (data.isPresent()) {


            List<String> videoExtension = Arrays.asList("webm", "mkv", "flv", "vob", "ogv", "ogg",
                    "rrc", "gifv", "mng", "mov", "avi", "qt", "wmv", "yuv", "rm", "asf", "amv", "mp4", "m4p", "m4v", "mpg", "mp2", "mpeg", "mpe",
                    "mpv", "m4v", "svi", "3gp", "3gpp", "3g2", "mxf", "roq", "nsv", "flv", "f4v", "f4p", "f4a", "f4b", "mod");

            String name = StringUtils.cleanPath(file.getOriginalFilename());

            String extension = StringUtils.getFilenameExtension(name);

            if (data.get().getUserEntity().getUsername().equals(user.getUsername())) {

                if (file.isEmpty()) {

                    return data.map(m -> {
                        m.setNombre(p.getNombre());
                        m.setDescripcion(p.getDescripcion());
                        m.setPosts(p.getPosts());
                        m.setCreatedDate(LocalDateTime.now());
                        m.setImagen(m.getImagen());
                        subPostsRepository.save(m);
                        return subPostDtoConverter.subPostToGetSubPostDto(m);
                    });

                } else if (!videoExtension.contains(extension)) {


                    String name2 = StringUtils.cleanPath(String.valueOf(data.get().getImagen())).replace("http://localhost:8080/download/", "")
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
                        m.setNombre(p.getNombre());
                        m.setDescripcion(p.getDescripcion());
                        m.setPosts(p.getPosts());
                        m.setCreatedDate(LocalDateTime.now());
                        m.setImagen(m.getImagen());
                        subPostsRepository.save(m);
                        return subPostDtoConverter.subPostToGetSubPostDto(m);
                    });

                } else {

                    String name2 = StringUtils.cleanPath(String.valueOf(data.get().getImagen())).replace("http://localhost:8080/download/", "")
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
                        m.setNombre(p.getNombre());
                        m.setDescripcion(p.getDescripcion());
                        m.setPosts(p.getPosts());
                        m.setCreatedDate(LocalDateTime.now());
                        m.setImagen(m.getImagen());
                        subPostsRepository.save(m);
                        return subPostDtoConverter.subPostToGetSubPostDto(m);
                    });
                }
            } else {
                throw new FileNotFoundException("No eres el propietario de esta publicación");
            }

        } else {
            throw new SingleEntityNotFoundException(id.toString(), SubPost.class);
        }
    }
}




