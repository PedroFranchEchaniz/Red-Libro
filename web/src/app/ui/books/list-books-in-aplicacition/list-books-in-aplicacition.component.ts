import { Component, OnInit, TemplateRef, inject } from '@angular/core';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { BookServiceService } from '../../../service/book-service.service';
import { AllBooks } from '../../../models/allBooks.interface';
import { ModalDismissReasons, NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';


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
  filter = new FormControl('');
  filteredBooks: AllBooks[] = [];
  bookForm!: FormGroup;
  content!: TemplateRef<any>;

  constructor(private fb: FormBuilder, private bookService: BookServiceService) { }

  ngOnInit() {
    this.getAllBooks();
    this.bookForm = this.fb.group({
      filter: ['']
    });
  }

  getAllBooks() {
    this.bookService.getAllBooks().subscribe(resp => {
      this.books = resp;
      this.filteredBooks = resp;
    })
  }

  filterBooks(value: string): AllBooks[] {
    return this.books.filter(book =>
      book.titulo.toLowerCase().includes(value.toLowerCase())
    );
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