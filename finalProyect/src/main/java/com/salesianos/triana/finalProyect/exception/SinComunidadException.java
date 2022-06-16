package com.salesianos.triana.finalProyect.exception;

import javax.persistence.EntityNotFoundException;

public class SinComunidadException extends Exception{

    public SinComunidadException(String mensaje) {
        super(mensaje);
    }

}

