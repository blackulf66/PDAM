import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { PostResponse } from '../model/interfaces/post.interface';


@Injectable({
  providedIn: 'root'
})
export class PostService {

  constructor(private http:HttpClient) { }

  getAllPosts():Observable<PostResponse[]> {
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      })

    return this.http.get<PostResponse[]>(`${environment.apiBaseUrl}/post/all`, {headers: headers});
  }

  deletePost(id: number): Observable<PostResponse[]> {
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      })
    return this.http.delete<PostResponse[]>(`${environment.apiBaseUrl}/post/${id}`, {headers: headers});
  }
}