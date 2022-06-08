package com.salesianos.triana.finalProyect.dto.vote;

import com.salesianos.triana.finalProyect.dto.user.GetUserDto2;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.model.Vote;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class VoteDtoConverter {
        public GetVoteDto convertvoteToGetvoteDto(Vote vote) {
            return GetVoteDto
                    .builder()
                    .postId(vote.getPost().getPostId())
                    .voteType(vote.getVoteType())
                    .user(vote.getUser())
                    .build();
        }

}
