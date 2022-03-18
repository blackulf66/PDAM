package com.salesianos.triana.finalProyect.config.audit;


import lombok.extern.java.Log;
import com.salesianos.triana.finalProyect.model.UserEntity;
import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.UUID;

import java.util.Optional;

@Log
public class SpringSecurityAuditorAware implements AuditorAware<UUID> {
    @Override
    public Optional<UUID> getCurrentAuditor() {

        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            log.info("Principal: " + authentication.getPrincipal());
            UserEntity user = (UserEntity) authentication.getPrincipal();
            return Optional.ofNullable(user.getUserId());
        } catch (Exception ex) {
            log.info("Error: " + ex.getMessage());
        }
        return Optional.empty();

    }
}
