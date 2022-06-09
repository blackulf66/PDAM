package com.salesianos.triana.finalProyect.service;

import com.salesianos.triana.finalProyect.dto.subpost.SubPostDtoConverter;
import com.salesianos.triana.finalProyect.dto.user.*;
import com.salesianos.triana.finalProyect.exception.FollowException;
import com.salesianos.triana.finalProyect.exception.UnsupportedMediaType;
import com.salesianos.triana.finalProyect.exception.VoteException;
import com.salesianos.triana.finalProyect.model.SubPost;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;
import io.jsonwebtoken.Jwt;
import lombok.RequiredArgsConstructor;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static java.util.stream.Collectors.toList;


@Service("userDetailsService")
@RequiredArgsConstructor
public class UserEntityService extends BaseService<UserEntity, UUID, UserEntityRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final StorageService storageService;
    private final UserEntityRepository userEntityRepository;
    private final UserDtoConverter userDtoConverter;
    private final SubPostsRepository subPostsRepository;
    private final SubPostDtoConverter subPostDtoConverter;

    public UserEntity saveuser(CreateUserDto newUser, MultipartFile file) throws IOException {

        String extension = StringUtils.getFilenameExtension(StringUtils.cleanPath(file.getOriginalFilename()));
        List<String> imagenExtension = Arrays.asList("png", "gif", "jpg", "svg");

        if (imagenExtension.contains(extension)) {
            String filename = storageService.escalado(file, 128);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(filename)
                    .toUriString()
                    .replace("10.0.2.2", "localhost");


            UserEntity user = UserEntity.builder()
                    .password(passwordEncoder.encode(newUser.getPassword()))
                    .avatar(uri)
                    .username(newUser.getUsername())
                    .email(newUser.getEmail())
                    .posts(newUser.getPostList())
                    .created(LocalDateTime.now())
                    .userRole(newUser.getUserRole())
                    .build();
            try {
                return save(user);
            } catch (DataIntegrityViolationException ex) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "El nombre de ese usuario ya existe");
            }
        } else {
            throw new UnsupportedMediaType(imagenExtension);
        }

    }


    public Optional<UserEntity> finduserByName(String name) {
        return userEntityRepository.findByUsername(name);
    }


        @Override
        public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
            return this.repositorio.findFirstByEmail(email)
                    .orElseThrow(()-> new UsernameNotFoundException(email + " no encontrado"));
        }

    public GetUserDto verPerfil(UserEntity user) {

        return userDtoConverter.convertUserEntityToGetUserDto2(user);


    }

    public UserEntity getCurrentUser() {
        Jwt principal = (Jwt) SecurityContextHolder.
                getContext().getAuthentication().getPrincipal();
        return userEntityRepository.findByUsername(getCurrentUser().getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("nombre de usuario no encontrado"));
    }

    public void addfollow(UserEntity user,Long SubpostId) throws FollowException {

        SubPost idSubpost = subPostsRepository.findById(SubpostId).get();

        UserEntity usuario = repositorio.findByEmail(user.getEmail()).get();


        if(usuario.getSubPostsList().contains(idSubpost)){
            throw new FollowException("ya sigues a este subpost");
        } else{
            usuario.getSubPostsList().add(idSubpost);
        }

    }

    public void removefollow(Long SubpostId , UserEntity user){

        SubPost idSubpost = subPostsRepository.findById(SubpostId).get();

        UserEntity usuario = repositorio.findByUsername(user.getUsername()).get();

        usuario.getSubPostsList().remove(idSubpost);

    }

    public Optional<GetUserDto2> updateUser (String nombre,CreateUserDto p, MultipartFile file , UserEntity user) throws EntityNotFoundException, IOException {

        Optional<UserEntity> data = userEntityRepository.findByUsername(nombre);

        String name2 = StringUtils.cleanPath(String.valueOf(data.get().getAvatar())).replace("http://localhost:8080/download/", "")
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
        if (data.get().getUsername().equals(user.getUsername())) {
            return data.map(m -> {
                m.setUsername(p.getUsername());
                m.setAvatar(uri);
                m.setPassword(p.getPassword());
                userEntityRepository.save(m);
                return userDtoConverter.convertUserEntityToGetUserDto(m);
            });
        } else {
            throw new FileNotFoundException("No eres el propietario de esta publicación");
        }
    }

    @Transactional()
    public List<GetFollowsDto> getAllfollows() {
        return userEntityRepository.findAll()
                .stream()
                .map(userDtoConverter::convertUserEntityFToGetUserDtoF)
                .collect(toList());
    }

    @Transactional()
    public List<GetUserDto> getAllusers() {
        return userEntityRepository.findAll()
                .stream()
                .map(userDtoConverter::convertUserEntityToGetUserDto2)
                .collect(toList());
    }




}