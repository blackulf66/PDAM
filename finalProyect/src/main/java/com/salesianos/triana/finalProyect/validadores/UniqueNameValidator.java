package com.salesianos.triana.finalProyect.validadores;


import com.salesianos.triana.finalProyect.repository.SubPostsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class UniqueNameValidator implements ConstraintValidator<UniqueName, String> {

    @Autowired
    private SubPostsRepository repositorio;

    @Override
    public void initialize(UniqueName constraintAnnotation) { }

    @Override
    public boolean isValid(String nombre, ConstraintValidatorContext context) {
        if (repositorio == null) {
            return true;
        } else {
            return StringUtils.hasText(nombre) && !repositorio.existsByNombre(nombre);
        }
    }
}


