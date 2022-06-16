import { Component, OnInit } from '@angular/core';
import { UserResponse } from 'src/app/model/interfaces/user.interface';
import { UserService } from 'src/app/service/user.service';


@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css']
})
export class UserListComponent implements OnInit {

  user: UserResponse[] = [];

  constructor(private userservice: UserService) { }

  ngOnInit(): void {
    this.userservice.getAllusers().subscribe(results =>{
      this.user = results;
      console.log(this.user)
    })
  }

}
