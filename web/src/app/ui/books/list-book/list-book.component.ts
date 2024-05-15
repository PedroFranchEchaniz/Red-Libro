import { Component, OnInit, TemplateRef } from '@angular/core';
import { Observable } from 'rxjs';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { Store } from '../../../models/getStore.interface';
import { Router } from '@angular/router';
import { ModalDismissReasons, NgbModal } from '@ng-bootstrap/ng-bootstrap';


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
  modalService: any;
  storeSelected!: Store;
  closeResult = '';
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
    this.mostrarFormulario = false;

    const amountEdited = {
      cantidad: this.cantidadEditada,
      uuid: this.uuid
    }
    console.log(amountEdited);
    this.storeService.editAmountStore(this.isbn, amountEdited).subscribe(
      response => {
        console.log('Respuesta del servidor:', response);
      },
      error => {
        console.error('Error:', error);
      }
    ); this.router.navigateByUrl('/', { skipLocationChange: true }).then(() => {
      this.getStore();
      this.router.navigate([location.pathname]);
    });
  }

  cancelar() {
    this.router.navigateByUrl('/', { skipLocationChange: true }).then(() => {
      this.router.navigate([location.pathname]);
    });
  }

  open(content: TemplateRef<any>, store: Store) {
    this.storeSelected = store;
    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then(
      (result) => {
        this.closeResult = `Closed with: ${result}`;
      },
      (reason) => {
        this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
      },
    );
  }

  private getDismissReason(reason: any): string {
    switch (reason) {
      case ModalDismissReasons.ESC:
        return 'by pressing ESC';
      case ModalDismissReasons.BACKDROP_CLICK:
        return 'by clicking on a backdrop';
      default:
        return `with: ${reason}`;
    }
  }
}