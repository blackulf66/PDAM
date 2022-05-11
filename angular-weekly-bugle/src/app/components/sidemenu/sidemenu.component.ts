import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-sidemenu',
  templateUrl: './sidemenu.component.html',
  styleUrls: ['./sidemenu.component.css']
})
export class SidemenuComponent implements OnInit {

  currentPage = 'profile';

  constructor(private router: Router) { }

  ngOnInit(): void {
    console.log(this.router.url);
  }

}