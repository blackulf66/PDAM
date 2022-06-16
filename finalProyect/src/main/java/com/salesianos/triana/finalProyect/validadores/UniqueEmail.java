package com.salesianos.triana.finalProyect.validadores;


import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueEmailValidator.class)
@Documented
public @interface UniqueEmail {
    String message() default "El nombre del email ya existe. Por favor, intenta crear el email con uno nuevo.";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}