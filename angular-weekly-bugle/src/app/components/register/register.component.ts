import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { AuthRegisterDto } from 'src/app/models/dto/register.dto';
import { AuthService } from 'src/app/services/auth.service';


@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  registerForm = new FormGroup({
    username: new FormControl(''),
    email: new FormControl(''),
    password: new FormControl(''),
  });

  registerDto = new AuthRegisterDto();
  constructor(private authService: AuthService) { }

  ngOnInit(): void {
  }

  doregister() {
    this.authService.register(this.registerDto).subscribe(rResult => {
      console.warn(this.registerForm.value);
      localStorage.setItem

    });
  }
  
  

}
