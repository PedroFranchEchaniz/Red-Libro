import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';

@Component({
  selector: 'app-list-book',
  templateUrl: './list-book.component.html',
  styleUrl: './list-book.component.css'
})
export class ListBookComponent implements OnInit {
  stores$: Observable<any> | undefined;  // Usaremos un Observable para manejar los datos de forma reactiva

  constructor(private storeService: StoreServiceService) { }

  ngOnInit() {
    this.stores$ = this.storeService.getStoresByShopUuid('uuid'); // Asegúrate de tener el UUID correcto aquí
  }
}