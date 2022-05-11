import { Component, OnInit } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { AuthSignUpDto } from '../model/dto/auth.dto';
import { AuthService } from '../service/auth.service';
import { RestService } from '../service/rest-service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  imagenPrevia: any;
  files: any = []
  loading: boolean | undefined;
  signUpDto = new AuthSignUpDto();

  constructor(private authService: AuthService,  private sanitizer: DomSanitizer, private rest: RestService) { }

  ngOnInit(): void {
  }

  doSignUp(){
  this.authService.register(this.signUpDto).subscribe(data =>{
    
  })
    
  }

  public onFileSelected(event: any) {
    const imagen = event.target.files[0];
    console.log(imagen);
    if (['image'].includes(imagen.type)) {
      console.log('Si es una imagen');
      this.files.push(imagen)
      
    } else {
      console.log('No es imagen');
      this.files.push(imagen)
    }
  }
  /**
   *
   * Esta funciones se encarga de enviar archivos al servidor
   */
  
}


