import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthLoginDto } from '../models/dto/auth.dto';
import { AuthRegisterDto } from '../models/dto/register.dto';
import { AuthLoginResponse } from '../models/interfaces/auth.interface';
import { RegisterResponse } from '../models/interfaces/register.interface';

const AUTH_BASE_URL = 'auth';
const DEFAULT_HEADERS = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json'
  })
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  authBaseUrl = `${environment.apiBaseUrl}/${AUTH_BASE_URL}`;

  constructor(private http: HttpClient) { }

  login(loginDto: AuthLoginDto): Observable<AuthLoginResponse> {
    let requestUrl = `${this.authBaseUrl}/login`;
    return this.http.post<AuthLoginResponse>(requestUrl, loginDto, DEFAULT_HEADERS);
  }

  register(registerDto: AuthRegisterDto): Observable<RegisterResponse> {
    let requestUrl = `${this.authBaseUrl}/signup`;
    return this.http.post<RegisterResponse>(requestUrl, registerDto, DEFAULT_HEADERS);
  }

  forgot() {
    let requestUrl = `${this.authBaseUrl}/forgot`;    
  }
}
