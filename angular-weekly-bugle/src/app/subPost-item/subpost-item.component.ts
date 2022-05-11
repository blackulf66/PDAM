import { Component, Input, OnInit } from '@angular/core';
import { SubPostResponse } from '../model/interfaces/subpost.interface';
import { SubPostService } from '../service/subpost.service';


@Component({
  selector: 'app-subpost-item',
  templateUrl: './subpost-item.component.html',
  styleUrls: ['./subpost-item.component.css']
})
export class SubpostItemComponent implements OnInit {


  @Input() subpostInput!: SubPostResponse;

  postsList: SubPostResponse[] | undefined;

  constructor(private subpostService: SubPostService) { }
  

  ngOnInit(): void {
  }

  getAvatar(avatar: string) {
    return `background-image: url('${avatar}'); background-size: cover;`
  }

  getAvatar2(post: SubPostResponse) {
    return `${post.imagen}`;
  }

  deletePost() {
    this.subpostService.deletePost(this.subpostInput.id).subscribe(res => {
      this.postsList = res;
      })
      alert("Se ha eliminado correctamente")
  };

}


