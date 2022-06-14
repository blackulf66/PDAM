import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SubPostDto } from '../model/dto/subpost.dto';
import { SubPostResponse } from '../model/interfaces/subpost.interface';

const headers = {
  'Content-Type': 'multipart/form-data',
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'Content-Type',
  "Access-Control-Max-Age": "3600",
  'Access-Control-Allow-Methods': 'GET,POST,OPTIONS,DELETE,PUT',
  'Authorization': `Bearer ${localStorage.getItem('token')}`
}



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

  deleteSubPost(id: number): Observable<SubPostResponse[]> {
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      })
    return this.http.delete<SubPostResponse[]>(`${environment.apiBaseUrl}/subpost/${id}`, {headers: headers});
  }
  
   AddSubpost(addsubpostDto: SubPostDto): Observable<SubPostResponse> {

  const headers = new HttpHeaders({
    "Content-Type":"multipart/form-data",
     'Authorization': `Bearer ${localStorage.getItem('token')}`
     
  })
  const parametros = {
    'nombre': addsubpostDto.nombre,
    'descripcion':addsubpostDto.descripcion,
    'file':addsubpostDto.file
  }

    let requestUrl = `https://pdam-prueba.herokuapp.com/subpost/`;
    // let params = new HttpParams()
    // .set('nombre', addsubpostDto.nombre)
    // .set('file', addsubpostDto.file)
    // .set('descripcion', addsubpostDto.descripcion)

  return this.http.post<SubPostResponse>(requestUrl , {queryParams : parametros} , {headers});
  }

  // AddSubpost(addsubpostDto: SubPostDto): Observable<any> {
  //   const headers = {
  //           'Authorization': `Bearer ${localStorage.getItem('token')}`
  //        }
  //   let requestUrl = `https://pdam-prueba.herokuapp.com/subpost/`;
  //   let params = new HttpParams().set('nombre', addsubpostDto.nombre)
  //     .set('file', addsubpostDto.file)
  //      .set('descripcion', addsubpostDto.descripcion)

  //   return this.http.post<any>(requestUrl, {'headers': headers, 'params': params});

  // }

}