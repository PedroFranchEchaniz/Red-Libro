import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../../environment/environment';
import { UserLoginRespomse } from '../../models/login-user.interface';

@Injectable({
  providedIn: 'root'
})
export class AccountServiceService {

  constructor(private http: HttpClient) { }

  loginAccount(username: string, password: string): Observable<UserLoginRespomse> {
    return this.http.post<UserLoginRespomse>(`${environment.apiBaseUrl}/shop/login`, {
      username: username,
      password: password
    }, {
      headers: {
        'Content-Type': 'application/json'
      }
    }
    )
  }
}
