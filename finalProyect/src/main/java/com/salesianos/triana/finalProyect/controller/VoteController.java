package com.salesianos.triana.finalProyect.controller;

import com.salesianos.triana.finalProyect.dto.vote.GetVoteDto;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.model.Vote;
import com.salesianos.triana.finalProyect.service.VoteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/votes")
@AllArgsConstructor
@CrossOrigin("*")
@Tag(name = "vote_Controller", description = "El controlador de votos")
public class VoteController {

    private final VoteService voteService;

    @Operation(summary = "consigues votar positiva o negativamente a un post")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "votas a un post",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = Vote.class))}),
            @ApiResponse(responseCode = "400",
                    description = "no se ha encontrado el post por nombre",
                    content = @Content),
    })

    @PostMapping("/")
    public ResponseEntity<Void> vote(@RequestBody GetVoteDto voteDto, @AuthenticationPrincipal UserEntity user) {

        voteService.vote(voteDto , user);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}


