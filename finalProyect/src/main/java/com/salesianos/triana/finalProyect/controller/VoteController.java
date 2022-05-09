package com.salesianos.triana.finalProyect.controller;

import com.salesianos.triana.finalProyect.dto.vote.GetVoteDto;
import com.salesianos.triana.finalProyect.service.VoteService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/votes")
@AllArgsConstructor
public class VoteController {

    private final VoteService voteService;

    @PostMapping("/")
    public ResponseEntity<Void> vote(@RequestBody GetVoteDto voteDto) {
        voteService.vote(voteDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}


