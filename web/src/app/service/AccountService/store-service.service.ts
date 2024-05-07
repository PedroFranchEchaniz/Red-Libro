import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Pageable, GetStoreResponse } from '../../models/getStore.interface';
import { Observable } from 'rxjs';
import { environment } from '../../../environment/environment';
import { Store } from '../../models/store';


@Injectable({
  providedIn: 'root'
})
export class StoreServiceService {

  constructor(private http: HttpClient) { }

  getStoresByShopUuid(uuid: string, page: number): Observable<GetStoreResponse> {
    const token = localStorage.getItem('token');

    console.log(token); // Asegúrate de obtener el token de localStorage
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`  // Usa la variable token aquí
    });
    return this.http.get<GetStoreResponse>(
      `${environment.apiBaseUrl}/store/${uuid}/stores?page=${page}`,
      { headers: headers }
    );
  }
}
