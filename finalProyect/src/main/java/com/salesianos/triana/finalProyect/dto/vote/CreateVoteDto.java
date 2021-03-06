package com.salesianos.triana.finalProyect.dto.vote;


import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.model.VoteType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CreateVoteDto {
    private VoteType voteType;
    private Long postId;
    private UserEntity user;
}