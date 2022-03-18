package repository;

import model.Post;
import model.SubPosts;

import java.util.List;

public interface SubPostsRepository extends JpaRepository<Post, Long> {

    Optional<SubPosts> findByName(String subredditName);




}
