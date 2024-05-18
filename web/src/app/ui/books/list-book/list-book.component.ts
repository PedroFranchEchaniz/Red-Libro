import { Component, OnInit, TemplateRef, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { Store } from '../../../models/getStore.interface';
import { Router } from '@angular/router';
import { ModalDismissReasons, NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';



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
  storeSelected!: Store;
  closeResult = '';
  private modalService = inject(NgbModal);
  private modalRef: NgbModalRef | undefined;


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
    this.storeSelected

    const amountEdited = {
      cantidad: this.storeSelected.cantidad,
      uuid: this.storeSelected.uuid
    }
    console.log(amountEdited);
    this.storeService.editAmountStore(this.storeSelected.isbn, amountEdited).subscribe(
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

    if (this.modalRef) {
      this.modalRef.close();
    }
  }

  cancelar() {
    this.router.navigateByUrl('/', { skipLocationChange: true }).then(() => {
      this.router.navigate([location.pathname]);
    });
    if (this.modalRef) {
      this.modalRef.close();
    }

  }

  open(content: TemplateRef<any>, store: Store) {
    this.storeSelected = store;
    this.modalRef = this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' });
    this.modalRef.result.then(
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