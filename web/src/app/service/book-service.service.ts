import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environment/environment';
import { Observable } from 'rxjs';
import { AllBooks } from '../models/allBooks.interface';


@Injectable({
  providedIn: 'root'
})
export class BookServiceService {

  constructor(private http: HttpClient) { }

  getAllBooks(): Observable<AllBooks[]> {
    const token = localStorage.getItem('token');

    console.log(token); // Asegúrate de obtener el token de localStorage
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`  // Usa la variable token aquí
    });
    return this.http.get<AllBooks[]>(
      `${environment.apiBaseUrl}/book/getAll`,
      { headers: headers }
    );
  }

}


