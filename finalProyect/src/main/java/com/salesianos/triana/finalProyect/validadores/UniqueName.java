package com.salesianos.triana.finalProyect.validadores;


import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueNameValidator.class)
@Documented
public @interface UniqueName {
    String message() default "El nombre del subpost ya existe. Por favor, intenta crear el subpost con uno nuevo.";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}