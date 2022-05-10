import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { environment } from "src/environments/environment";
import { Like, LikeResponse } from "../models/interfaces/twit.interface";


@Injectable({
  providedIn: 'root'
})
export class TwitService {
  

  constructor(private http: HttpClient) { }

  getAllTwits(): Observable<LikeResponse> {
    return this.http.get<LikeResponse>(`${environment.apiBaseUrl}/tweets/get_tweets_all`);
  }

  getTwit(id: number): Observable<Like>{
    return this.http.get<Like>(`${environment.apiBaseUrl}/tweets/${id}`);
  }

}