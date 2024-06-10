import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { BookingResponse } from '../models/shopBookings.interface';
import { environment } from '../../environment/environment';

@Injectable({
  providedIn: 'root'
})
export class BookingServiceService {

  constructor(private http: HttpClient) { }

  getBookingShop(page: number): Observable<BookingResponse> {
    const token = localStorage.getItem('token');
    const uuid = localStorage.getItem('uuid')

    console.log(token);
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<BookingResponse>(
      `${environment.apiBaseUrl}/shopBooking/${uuid}?page=${page}`,
      { headers: headers }
    );
  }

  deleteBooking(uuid: string, bookIsbn: string, shopUuid: string): Observable<void> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    const url = `${environment.apiBaseUrl}/shopBooking/delete/${uuid}?bookisbn=${bookIsbn}&shopUuid=${shopUuid}`;
    return this.http.delete<void>(url, { headers: headers });
  }
}
