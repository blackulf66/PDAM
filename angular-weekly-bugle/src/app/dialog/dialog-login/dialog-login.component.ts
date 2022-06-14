import { Component, OnInit } from '@angular/core';
import {Router } from '@angular/router';
import { AuthLoginDto } from 'src/app/model/dto/auth.dto';
import { AuthService } from 'src/app/service/auth.service';

@Component({
  selector: 'app-dialog-login',
  templateUrl: './dialog-login.component.html',
  styleUrls: ['./dialog-login.component.css']
})
export class DialogLoginComponent implements OnInit {

  loginDto = new AuthLoginDto();

  constructor(private authService: AuthService , private router: Router) { }

  ngOnInit(): void {
  }

  doLogin() {
    this.authService.login(this.loginDto).subscribe(loginResult => {
      alert(`Te has logueado y tu token es ${loginResult.token}`)
      localStorage.setItem('token', loginResult.token )
      this.router.navigate(['menu'])

    });
  }

}
 

