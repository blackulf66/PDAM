package com.salesianos.triana.finalProyect.model;

import com.salesianos.triana.finalProyect.exception.FileNotFoundException;

import java.util.Arrays;

public enum VoteType {
    LIKE(1), DISLIKE(-1),
    ;

    private int direction;

    VoteType(int direction) {


    }

    public static VoteType lookup(Integer direction) {
        return Arrays.stream(VoteType.values())
                .filter(value -> value.getDirection().equals(direction))
                .findAny()
                .orElseThrow(() -> new FileNotFoundException("voto no encontrado"));
    }

    public Integer getDirection() {
        return direction;
    }
}