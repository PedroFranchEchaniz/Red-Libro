import { Component, OnInit, TemplateRef, inject } from '@angular/core';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { BookServiceService } from '../../../service/book-service.service';
import { AllBooks } from '../../../models/allBooks.interface';
import { ModalDismissReasons, NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-list-books-in-aplicacition',
  templateUrl: './list-books-in-aplicacition.component.html',
  styleUrl: './list-books-in-aplicacition.component.css'
})
export class ListBooksInAplicacitionComponent implements OnInit {

  books!: AllBooks[];
  mostrarFormulario: boolean = false;
  router: any;
  resumen!: string;
  number: number = 0;
  private modalService = inject(NgbModal);
  closeResult = '';
  bookSelected!: AllBooks;
  constructor(private bookService: BookServiceService) { }

  ngOnInit() {
    this.getAllBooks();
  }

  getAllBooks() {
    this.bookService.getAllBooks().subscribe(resp => {
      this.books = resp;
    })
  }

  open(content: TemplateRef<any>, book: AllBooks) {
    this.bookSelected = book;
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
