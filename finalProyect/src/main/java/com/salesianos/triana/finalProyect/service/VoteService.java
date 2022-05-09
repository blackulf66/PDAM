package com.salesianos.triana.finalProyect.service;

import com.salesianos.triana.finalProyect.dto.vote.GetVoteDto;
import com.salesianos.triana.finalProyect.exception.FileNotFoundException;
import com.salesianos.triana.finalProyect.model.Post;
import com.salesianos.triana.finalProyect.model.UserEntity;
import com.salesianos.triana.finalProyect.model.Vote;
import com.salesianos.triana.finalProyect.repository.PostRepository;
import com.salesianos.triana.finalProyect.repository.VoteRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

import static com.salesianos.triana.finalProyect.model.VoteType.LIKE;

@Service
@AllArgsConstructor
public class VoteService {

    private final VoteRepository voteRepository;
    private final PostRepository postRepository;
    private final UserEntityService authService;

    @Transactional
    public void vote(GetVoteDto voteDto , UserEntity user) {
        Post post = postRepository.findById(voteDto.getPostId())
                .orElseThrow(() -> new FileNotFoundException("Post no encontrado con ID - " + voteDto.getPostId()));
        Optional<Vote> voteByPostAndUser = voteRepository.findTopByPostAndUserOrderByVoteIdDesc(post, user);
        if (voteByPostAndUser.isPresent() &&
                voteByPostAndUser.get().getVoteType()
                        .equals(voteDto.getVoteType())) {
            throw new FileNotFoundException("a"
                    + voteDto.getVoteType() + "aa");
        }
        if (LIKE.equals(voteDto.getVoteType())) {
            post.setVoteCount(post.getVoteCount() + 1);
        } else {
            post.setVoteCount(post.getVoteCount() - 1);
        }
        voteRepository.save(mapToVote(voteDto, post , user));
        postRepository.save(post);
    }

    private Vote mapToVote(GetVoteDto voteDto, Post post, UserEntity user) {
        return Vote.builder()
                .voteType(voteDto.getVoteType())
                .post(post)
                .user(user)
                .build();
    }
}