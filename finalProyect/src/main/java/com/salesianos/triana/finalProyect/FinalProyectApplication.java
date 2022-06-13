package com.salesianos.triana.finalProyect;

import com.salesianos.triana.finalProyect.config.StorageProperties;
import com.salesianos.triana.finalProyect.service.StorageService;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)


@OpenAPIDefinition(info =
@Info(description = "Weekly bugle API",
		version = "1.0",
		contact = @Contact(email = "javiernavarro66@gmail.com", name = "The BlackUlf"),
		license = @License(name = ":O"),
		title = "API Weekly Bugle"
)
)
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