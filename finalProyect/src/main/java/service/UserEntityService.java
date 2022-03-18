package service;

import com.salesianostriana.dam.dto.peticion.CreateSeguimientoDTO;
import com.salesianostriana.dam.exception.UserException;
import com.salesianostriana.dam.model.Seguimiento;
import com.salesianostriana.dam.repository.SeguimientoRepository;
import com.salesianostriana.dam.users.dtos.CreateUserDto;
import com.salesianostriana.dam.users.dtos.GetUserDto;
import com.salesianostriana.dam.users.dtos.UserDtoConverter;
import com.salesianostriana.dam.users.models.UserEntity;
import com.salesianostriana.dam.users.models.UserRole;
import com.salesianostriana.dam.users.repositorys.UserEntityRepository;
import dto.user.CreateUserDto;
import dto.user.GetUserDto;
import dto.user.UserDtoConverter;
import lombok.RequiredArgsConstructor;
import model.UserEntity;
import model.UserRole;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import repository.UserEntityRepository;

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

            BufferedImage scaledImage = storageService.simpleResizer(originalImage,128);

            OutputStream outputStream = Files.newOutputStream(storageService.load(filename));

            ImageIO.write(scaledImage,extension,outputStream);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(filename)
                    .toUriString();

            if (newUser.getPassword().contentEquals(newUser.getPassword())) {
                UserEntity userEntity = UserEntity.builder()
                        .password(passwordEncoder.encode(newUser.getPassword()))
                        .avatar(uri)
                        .nick(newUser.getNick())
                        .email(newUser.getEmail())
                        .role(UserRole.USER)
                        .posts(newUser.getPosts())
                        .build();
                return save(userEntity);
            } else {
                return null;
            }
        }


    public Optional<UserEntity> finduserById(UUID id){
        return userEntityRepository.findById(id);
    }

    public Optional<GetUserDto> updateUser (UUID id, CreateUserDto p, MultipartFile file , UserEntity user) throws EntityNotFoundException {

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

    public UserEntity editProfile(UserEntity user, GetUsuarioMoreDetailsDTO usuarioDto, MultipartFile file) throws IOException {

        storageService.deleteFile(usuario.getFoto());
        String uri = postService.uploadFiles(file).get(0);

        user.setNickname(usuarioDto.getNickname());
        user.setFullname(usuarioDto.getNombre());
        usuario.setEmail(usuarioDto.getEmail());
        usuario.setBiografia(usuarioDto.getDescripcion());
        usuario.setFechaNacimiento(usuarioDto.getFechaNacimiento());
        usuario.setFoto(uri);
        usuario.setVisibilidad(usuarioDto.getVisibilidad());
        usuario.setPassword(usuarioDto.getPassword());

        passwordEncoder.encode(usuarioDto.getPassword());

        repositorio.save(usuario);

        return usuario;

    }


}
    }

}