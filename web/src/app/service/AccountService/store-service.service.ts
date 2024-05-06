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

  getStoresByShopUuid(uuid: string): Observable<Store[]> {
    const token = localStorage.getItem('token');  // Suponiendo que el token se almacene en localStorage
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`  // Asumiendo que usas un esquema Bearer
    });
    return this.http.get<Store[]>(`${environment.apiBaseUrl}/store/${uuid}/stores`, { headers: headers });
  }
}
