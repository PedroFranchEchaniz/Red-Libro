import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../../environment/environment';
import { UserLoginRespomse } from '../../models/login-user.interface';
import { AllClientsDto, GetAllClientsResponse } from '../../models/allClientsResponse.interface';


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

  getclients(page: number): Observable<GetAllClientsResponse> {
    const token = localStorage.getItem('token');

    console.log(token);
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<GetAllClientsResponse>(
      `${environment.apiBaseUrl}/shopClient/allUser?page=${page}`,
      { headers: headers }
    );
  }

  toogleBann(uuid: string): Observable<AllClientsDto> {
    const token = localStorage.getItem('token');

    console.log(token);
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<AllClientsDto>(
      `${environment.apiBaseUrl}/shopClient/bann/${uuid}`,
      { headers: headers }
    );
  }
}


