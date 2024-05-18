import { Component, OnInit, TemplateRef, inject } from '@angular/core';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { BookServiceService } from '../../../service/book-service.service';
import { AllBooks } from '../../../models/allBooks.interface';
import { ModalDismissReasons, NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { debounceTime } from 'rxjs/operators';

@Component({
  selector: 'app-list-books-in-aplicacition',
  templateUrl: './list-books-in-aplicacition.component.html',
  styleUrls: ['./list-books-in-aplicacition.component.css']
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

    this.bookForm.get('filter')?.valueChanges.pipe(
      debounceTime(300) // Añade un retardo para evitar filtrar en cada pulsación de tecla
    ).subscribe(value => {
      this.filteredBooks = this.filterBooks(value);
    });
  }

  getAllBooks() {
    this.bookService.getAllBooks().subscribe(resp => {
      this.books = resp;
      this.filteredBooks = resp; // Inicialmente, muestra todos los libros
    });
  }

  filterBooks(value: string): AllBooks[] {
    const filterValue = value.toLowerCase();
    return this.books.filter(book =>
      book.titulo.toLowerCase().includes(filterValue) ||
      book.autor.toLowerCase().includes(filterValue)
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
