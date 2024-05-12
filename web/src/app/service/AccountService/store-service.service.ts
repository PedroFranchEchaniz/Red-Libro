import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Pageable, GetStoreResponse } from '../../models/getStore.interface';
import { Observable } from 'rxjs';
import { environment } from '../../../environment/environment';
import { AmountEdited } from '../../models/amountStore.interface';


@Injectable({
  providedIn: 'root'
})
export class StoreServiceService {

  constructor(private http: HttpClient) { }

  getStoresByShopUuid(uuid: string, page: number): Observable<GetStoreResponse> {
    const token = localStorage.getItem('token');

    console.log(token);
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<GetStoreResponse>(
      `${environment.apiBaseUrl}/store/${uuid}/stores?page=${page}`,
      { headers: headers }
    );
  }

  editAmountStore(isbn: string, editAmount: AmountEdited): Observable<GetStoreResponse> {
    console.log('Aqui llega');
    console.log(editAmount.uuid)
    return this.http.put<GetStoreResponse>(
      `${environment.apiBaseUrl}/store/edit/${isbn}`, editAmount,
      {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
      });
  }

}
