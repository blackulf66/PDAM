import { Component, OnInit } from '@angular/core';
import { Router} from '@angular/router';
import { AuthLoginDto } from '../model/dto/auth.dto';
import { AuthService } from '../service/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

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
