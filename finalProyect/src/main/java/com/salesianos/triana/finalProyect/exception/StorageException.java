package com.salesianos.triana.finalProyect.exception;


import java.io.IOException;

public class StorageException extends RuntimeException {

    public StorageException(String message, Exception e) {
        super(message, e);
    }

    public StorageException(String message) {
        super(message);
    }
}