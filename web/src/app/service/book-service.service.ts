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

    console.log(token);
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<AllBooks[]>(
      `${environment.apiBaseUrl}/book/getAll`,
      { headers: headers }
    );
  }

  newBook(data: FormData): Observable<any> {
    const token = localStorage.getItem('token');
    let headers = new HttpHeaders();
    headers = headers.set('Authorization', `Bearer ${token}`);

    return this.http.post<any>(
      `${environment.apiBaseUrl}/book/newBook`,
      data,
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


