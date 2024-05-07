import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { Store } from '../../../models/getStore.interface';

@Component({
  selector: 'app-list-book',
  templateUrl: './list-book.component.html',
  styleUrl: './list-book.component.css'
})
export class ListBookComponent implements OnInit {
  stores!: Store[];
  uuid: string | null = localStorage.getItem('uuid') // Usaremos un Observable para manejar los datos de forma reactiva

  constructor(private storeService: StoreServiceService) { }

  ngOnInit() {
    this.getStore();
  }

  getStore() {
    if (this.uuid) { // Verificar si uuid no es null
      this.storeService.getStoresByShopUuid(this.uuid, 0).subscribe(resp => {
        this.stores = resp.content;
      });
    } else {
      console.error('No UUID found in localStorage.');
      // Aquí podrías redirigir al usuario o mostrar un mensaje
    }
  }
}