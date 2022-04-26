package com.salesianos.triana.finalProyect.service;

import com.salesianos.triana.finalProyect.dto.user.CreateUserDto;
import com.salesianos.triana.finalProyect.dto.user.GetUserDto;
import com.salesianos.triana.finalProyect.dto.user.GetUserDto2;
import com.salesianos.triana.finalProyect.dto.user.UserDtoConverter;
import com.salesianos.triana.finalProyect.exception.UnsupportedMediaType;
import com.salesianos.triana.finalProyect.model.UserRole;
import com.salesianos.triana.finalProyect.repository.SubPostsRepository;
import lombok.RequiredArgsConstructor;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.jpa.repository.Query;
import org.springframework.http.HttpStatus;
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

import javax.imageio.ImageIO;
import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service("userDetailsService")
@RequiredArgsConstructor
public class UserEntityService extends BaseService<UserEntity, UUID, UserEntityRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final StorageService storageService;
    private final UserEntityRepository userEntityRepository;
    private final UserDtoConverter userDtoConverter;
    private final SubPostsRepository subPostsRepository;

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
                    .Subposts(newUser.getSubpostList())
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


    public Optional<UserEntity> finduserById(UUID id) {
        return userEntityRepository.findById(id);
    }


        @Override
        public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
            return this.repositorio.findFirstByEmail(email)
                    .orElseThrow(()-> new UsernameNotFoundException(email + " no encontrado"));
        }
    public GetUserDto visializarPerfif(UserEntity user) {

        return userDtoConverter.convertUserEntityToGetUserDto2(user);


    }

}