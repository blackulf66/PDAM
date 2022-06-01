package com.salesianos.triana.finalProyect.dto.user;


import com.salesianos.triana.finalProyect.dto.subpost.GetSubPostDto3;
import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetFollowsDto {

    private String username;

    private List<GetSubPostDto3> following;


}
