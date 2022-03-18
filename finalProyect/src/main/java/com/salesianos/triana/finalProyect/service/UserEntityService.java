package com.salesianos.triana.finalProyect.service;

import com.salesianos.triana.finalProyect.dto.user.CreateUserDto;
import com.salesianos.triana.finalProyect.dto.user.GetUserDto;
import com.salesianos.triana.finalProyect.dto.user.UserDtoConverter;
import lombok.RequiredArgsConstructor;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import com.salesianos.triana.finalProyect.repository.UserEntityRepository;

import javax.imageio.ImageIO;
import javax.persistence.EntityNotFoundException;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;
import java.util.UUID;

@Service("userDetailsService")
@RequiredArgsConstructor

public class UserEntityService extends BaseService<UserEntity, UUID, UserEntityRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final StorageService storageService;
    private final UserEntityRepository userEntityRepository;
    private final UserDtoConverter userDtoConverter;

    public UserEntity saveuser(CreateUserDto newUser, MultipartFile file) throws IOException {

        String filename = storageService.store(file);

        String extension = StringUtils.getFilenameExtension(filename);

        BufferedImage originalImage = ImageIO.read(file.getInputStream());

        BufferedImage scaledImage = storageService.simpleResizer(originalImage, 128);

        OutputStream outputStream = Files.newOutputStream(storageService.load(filename));

        ImageIO.write(scaledImage, extension, outputStream);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(filename)
                .toUriString();

        if (newUser.getPassword().contentEquals(newUser.getPassword())) {
            UserEntity user = UserEntity.builder()
                    .password(passwordEncoder.encode(newUser.getPassword()))
                    .avatar(uri)
                    .username(newUser.getUsername())
                    .email(newUser.getEmail())
                    .Subposts(newUser.getSubpostList())
                    .build();
            return save(user);
        } else {
            return null;
        }
    }

    public Optional<UserEntity> finduserById(UUID id) {
        return userEntityRepository.findById(id);
    }



    public Optional<GetUserDto> updateUser(UUID id, CreateUserDto p, MultipartFile file, UserEntity user) throws EntityNotFoundException {

        Optional<UserEntity> data = userEntityRepository.findById(id);
        String name = StringUtils.cleanPath(String.valueOf(data.get().getAvatar())).replace("http://localhost:8080/download", "");
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
            m.setUsername(p.getUsername());
            m.setAvatar(uri);
            m.setEmail(p.getEmail());
            m.setPassword(p.getPassword());
            userEntityRepository.save(m);
            return userDtoConverter.convertUserEntityToGetUserDto(m);
        });
    }

    public Optional<GetUserDto> actualizarPerfil(UserEntity user, CreateUserDto u, MultipartFile file) throws Exception {
        if (file.isEmpty()){
            Optional<UserEntity> data = userEntityRepository.findById(user.getUserId());
            return data.map(m -> {
                m.setUsername(u.getUsername());
                m.setEmail(u.getEmail());
                m.setAvatar(u.getAvatar());
                m.setAvatar(m.getAvatar());
                m.setEmail(u.getEmail());
                userEntityRepository.save(m);
                return userDtoConverter.convertUserEntityToGetUserDto(m);
            });
        }else{

            Optional<UserEntity> data = userEntityRepository.findById(user.getUserId());
            String name = StringUtils.cleanPath(String.valueOf(data.get().getAvatar())).replace("http://localhost:8080/download/", "");
            Path p = storageService.load(name);
            String filename = StringUtils.cleanPath(String.valueOf(p)).replace("http://localhost:8080/download/", "");
            Path pa = Paths.get(filename);
            storageService.deleteFile(pa.toString());
            String avatar = storageService.storePost(file);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(avatar)
                    .toUriString();

            return data.map(m -> {
                m.setUsername(u.getUsername());
                m.setAvatar(u.getAvatar());
                m.setAvatar(uri);
                m.setEmail(u.getEmail());
                userEntityRepository.save(m);
                return userDtoConverter.convertUserEntityToGetUserDto(m);
            });

        }
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return (UserDetails) this.repositorio.findByUsername(username)
                .orElseThrow(()-> new UsernameNotFoundException(username + " no encontrado"));
    }
}