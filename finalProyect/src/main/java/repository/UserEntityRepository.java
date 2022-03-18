package repository;

import model.UserEntity;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {

    @Override
    Optional<UserEntity> findById(UUID uuid);

    Optional<UserEntity> findByUsername(String username);

}

