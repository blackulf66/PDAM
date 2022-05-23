import { Component, OnInit } from '@angular/core';
import { PostResponse } from 'src/app/models/interfaces/post.interface';
import { PostService } from 'src/app/services/post.service';

@Component({
  selector: 'app-post-list',
  templateUrl: './post-list.component.html',
  styleUrls: ['./post-list.component.css']
})
export class PostListComponent implements OnInit {


  postList!: PostResponse[];
  allpostList!: PostResponse[];


  constructor(private postService: PostService) { }

  ngOnInit(): void {
    this.postService.getAllPosts().subscribe(data => {this.postList = data})
      console.log(this.postList)
  }

}
