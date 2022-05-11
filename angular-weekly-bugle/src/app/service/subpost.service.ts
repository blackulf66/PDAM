import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SubPostResponse } from '../model/interfaces/subpost.interface';


@Injectable({
  providedIn: 'root'
})
export class SubPostService {

  constructor(private http:HttpClient) { }

  getAllPosts():Observable<SubPostResponse[]> {
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      })

    return this.http.get<SubPostResponse[]>(`${environment.apiBaseUrl}/subpost/all`, {headers: headers});
  }

  deletePost(id: number): Observable<SubPostResponse[]> {
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      })
    return this.http.delete<SubPostResponse[]>(`${environment.apiBaseUrl}/subpost/${id}`, {headers: headers});
  }
}