package com.salesianos.triana.finalProyect.exception;

import javax.persistence.EntityNotFoundException;

public class DynamicException extends EntityNotFoundException {
    public DynamicException(String mensaje) {
        super(mensaje);
    }
}