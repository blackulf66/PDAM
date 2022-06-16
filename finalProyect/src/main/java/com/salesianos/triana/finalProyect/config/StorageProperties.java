package com.salesianos.triana.finalProyect.config;


import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;

@ConfigurationProperties(prefix = "storage")
@Getter @Setter
@Service
public class StorageProperties {

    private String location;


}