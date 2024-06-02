import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environment/environment';
import { Observable } from 'rxjs';
import { AllBooks } from '../models/allBooks.interface';
import { newBook } from '../models/newBook.interface';
import { newBookResponse } from '../models/newBookResponse.interface';
import { EditBook } from '../models/editBook.interface';


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

  newBook(newBook: newBook): Observable<newBook> {
    const token = localStorage.getItem('token');
    console.log(newBook.ISBN);
    console.log(token);
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json' // Asegúrate de tener el Content-Type correcto
    });
    return this.http.post<newBook>(
      `${environment.apiBaseUrl}/book/newBook`, newBook,
      { headers: headers }
    );
  }

  editBook(isbn: String, editBook: EditBook): Observable<EditBook> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    });
    return this.http.put<EditBook>(
      `${environment.apiBaseUrl}/book/edit/${isbn}`, editBook,
      { headers: headers }
    )
  }

}


