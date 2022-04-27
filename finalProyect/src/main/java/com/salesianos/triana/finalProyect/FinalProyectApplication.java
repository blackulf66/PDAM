package com.salesianos.triana.finalProyect;

import com.salesianos.triana.finalProyect.config.StorageProperties;
import com.salesianos.triana.finalProyect.service.StorageService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)

public class FinalProyectApplication {

	public static void main(String[] args) {
		SpringApplication.run(FinalProyectApplication.class, args);
	}

	@Bean
	public CommandLineRunner init (StorageService storageService){
		return args -> {
			storageService.deleteAll();
			storageService.init();

		};
	}

}