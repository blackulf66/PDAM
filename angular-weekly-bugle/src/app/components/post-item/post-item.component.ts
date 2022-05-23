import { Component, Input, OnInit } from '@angular/core';
import { PostResponse } from 'src/app/models/interfaces/post.interface';
import { PostService } from 'src/app/services/post.service';

@Component({
  selector: 'app-post-item',
  templateUrl: './post-item.component.html',
  styleUrls: ['./post-item.component.css']
})
export class PostItemComponent implements OnInit {

  @Input() postInput!: PostResponse;
  postsList: PostResponse[] | undefined;

  constructor(private postService: PostService) { }

  ngOnInit(): void {
  }

  deletePost() {
    this.postService.deletePost(this.postInput.id).subscribe(resp => {
      this.postsList = resp;
      })
      alert("Se ha eliminado correctamente")
  };


}
