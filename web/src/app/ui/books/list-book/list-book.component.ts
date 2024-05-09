import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { Store } from '../../../models/getStore.interface';
import { Router } from '@angular/router';


@Component({
  selector: 'app-list-book',
  templateUrl: './list-book.component.html',
  styleUrl: './list-book.component.css'
})
export class ListBookComponent implements OnInit {
  stores!: Store[];
  uuid: string | null = localStorage.getItem('uuid')
  mostrarFormulario: boolean = false
  cantidadEditada: number = 0;
  isbn!: string;
  pk!: string;
  constructor(private storeService: StoreServiceService, private router: Router) { }

  ngOnInit() {
    this.getStore();
  }

  getStore() {
    this.uuid = localStorage.getItem('uuid');
    if (this.uuid) {
      this.storeService.getStoresByShopUuid(this.uuid, 0).subscribe(resp => {
        this.stores = resp.content;
      });
    } else {
      console.error('No UUID found in localStorage.');
    }
  }

  confirmarCambio() {
    console.log('Nueva cantidad confirmada:', this.cantidadEditada);
    console.log(this.isbn);
    console.log(this.pk);
    console.log(this.uuid);
    this.mostrarFormulario = false;
  }

  cancelar() {
    this.router.navigateByUrl('/', { skipLocationChange: true }).then(() => {
      this.router.navigate([location.pathname]);
    });
  }
}