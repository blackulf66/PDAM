import { Component, Input, OnInit } from '@angular/core';
import { UserResponse } from 'src/app/model/interfaces/user.interface';
import { UserService } from 'src/app/service/user.service';



@Component({
  selector: 'app-user-item',
  templateUrl: './user-item.component.html',
  styleUrls: ['./user-item.component.css']
})
export class UserItemComponent implements OnInit {


  @Input() userInput!: UserResponse;

  usersList: UserResponse[] | undefined;

  constructor(private userservice: UserService) { }
  

  ngOnInit(): void {
  }

}


