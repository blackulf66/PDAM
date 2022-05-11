import { Component, OnInit } from '@angular/core';
import { SubPostResponse } from '../model/interfaces/subpost.interface';
import { SubPostService } from '../service/subpost.service';

@Component({
  selector: 'app-subpost-list',
  templateUrl: './subpost-list.component.html',
  styleUrls: ['./subpost-list.component.css']
})
export class SubpostListComponent implements OnInit {

  subpost: SubPostResponse[] = [];

  constructor(private postService: SubPostService) { }

  ngOnInit(): void {
    this.postService.getAllPosts().subscribe(results =>{
      this.subpost = results;
      console.log(this.subpost)
    })
  }

}
