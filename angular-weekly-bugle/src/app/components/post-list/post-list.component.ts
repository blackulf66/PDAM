import { Component, OnInit } from '@angular/core';
import { PostResponse } from 'src/app/model/interfaces/post.interface';
import { PostService } from 'src/app/service/post.service';

@Component({
  selector: 'app-post-list',
  templateUrl: './post-list.component.html',
  styleUrls: ['./post-list.component.css']
})
export class PostListComponent implements OnInit {


  post: PostResponse[] = [];

  constructor(private postService: PostService) { }

  getAvatar(avatar: string) {
    return `background-image: url('${avatar}'); background-size: cover;`
  }

  getAvatar2(post: PostResponse) {
    return `${post.imagenportada}`;
  }

  ngOnInit(): void {
    this.postService.getAllPosts().subscribe(results =>{
      this.post = results;
      console.log(this.post)
    })
  }
}
