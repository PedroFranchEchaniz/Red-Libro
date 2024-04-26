import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserLoginResponse } from '../models/user-login.interface';
import { environment } from '../envitonment/environment';

@Injectable({
  providedIn: 'root'
})
export class AccountService {

  constructor(private http: HttpClient) { }

  loginAccount(username: string, password: string): Observable<UserLoginResponse> {
    return this.http.post<UserLoginResponse>(`${environment.apiBaseUrl}/shop/login`, {
      username: username,
      password: password
    }, {
      headers: {
        'Content-Type': 'application/json',
      }
    })

  }
}
