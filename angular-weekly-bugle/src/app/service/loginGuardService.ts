import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from './user.service';

@Injectable({
  providedIn: 'root'
})
export class LoginGuardService {

  constructor(
    private userService: UserService,
    private router: Router
  ) { }

  async canActivate(): Promise<boolean> {
    return new Promise((resolve) => {
      const variable1 = this.userService.getToken()
      console.log(variable1)
        if (variable1 == null) {
          resolve(false);
          this.router.navigate(['login']);
        } else {
          resolve(true);
        }
      });
    }
  }



