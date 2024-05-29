import { Component, OnInit, TemplateRef, inject } from '@angular/core';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { BookServiceService } from '../../../service/book-service.service';
import { AllBooks } from '../../../models/allBooks.interface';
import { ModalDismissReasons, NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { debounceTime } from 'rxjs/operators';
import { newBook } from '../../../models/newBook.interface';
import { Store } from '../../../models/getStore.interface';
import { newStore } from '../../../models/adToStore.interface';
import { EditBook } from '../../../models/editBook.interface';
import { Observable } from 'rxjs';
import { book } from 'ngx-bootstrap-icons';

@Component({
  selector: 'app-list-books-in-aplicacition',
  templateUrl: './list-books-in-aplicacition.component.html',
  styleUrls: ['./list-books-in-aplicacition.component.css']
})
export class ListBooksInAplicacitionComponent implements OnInit {

  books!: AllBooks[];
  storeBooks!: Store[];
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
  newBook: newBook = {
    ISBN: '',
    titulo: '',
    autor: '',
    editorial: '',
    portda: '',
    fecha: '',
    genres: [],
    resumen: '',
    mediaValoracion: 0
  };
  newStore: newStore = { bookIsbn: '', shopUuid: '', cantidad: 0, precio: 0 }; // Inicialización de newStore
  selectedGenres: string[] = [];
  availableGenres: string[] = ['Ficción', 'No ficción', 'Drama', 'Misterio', 'Romance', 'Aventura', 'Fantasia', 'Ciencia ficción', 'Thriller', 'Terror', 'Biografía', 'Autobiografía', 'Poesía', 'Ensayo', 'Historia'];
  imagePreview: string | ArrayBuffer | null = null;
  editBookData: any = {
    titulo: '',
    autor: '',
    editorial: '',
    resumen: '',
    fecha: '',
    genres: [],
    uuid: ''
  };

  constructor(private fb: FormBuilder, private bookService: BookServiceService, private storeService: StoreServiceService) { }

  ngOnInit() {
    this.getAllBooks();
    this.getStoreBooks();
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

  getStoreBooks() {
    const uuid = localStorage.getItem('uuid');
    if (uuid) {
      this.storeService.getStoresByShopUuid(uuid, 0).subscribe(resp => {
        this.storeBooks = resp.content;
      });
    }
  }

  filterBooks(value: string): AllBooks[] {
    const filterValue = value.toLowerCase();
    return this.books.filter(book =>
      book.titulo.toLowerCase().includes(filterValue) ||
      book.autor.toLowerCase().includes(filterValue)
    );
  }

  bookInStore(isbn: string): boolean {
    return this.storeBooks.some(storeBook => storeBook.isbn === isbn);
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
  };

  openAddBookModal(content: TemplateRef<any>) {
    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then(
      (result) => {
        this.closeResult = `Closed with: ${result}`;
      },
      (reason) => {
        this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
      },
    );
  }

  onFileSelected(event: any) {
    const file: File = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => {
        this.imagePreview = reader.result;
        this.newBook.portda = reader.result as string;
      };
      reader.readAsDataURL(file);
    }
  }

  saveBook() {
    const fechaActual = new Date();

    const año = fechaActual.getFullYear();
    const mes = ('0' + (fechaActual.getMonth() + 1)).slice(-2);
    const dia = ('0' + fechaActual.getDate()).slice(-2);
    const fechaFormateada = `${año}-${mes}-${dia}`;

    this.newBook.genres = this.selectedGenres;
    this.newBook.fecha = fechaFormateada;
    console.log(this.newBook);
    this.bookService.newBook(this.newBook).subscribe(
      response => {
        console.log('Respuesta del servidor:', response);
      },
      error => {
        console.error('Error:', error);
      }
    );
  }

  addToStore(isbn: string) {
    console.log(isbn);
    this.newStore.bookIsbn = isbn;
    this.newStore.shopUuid = localStorage.getItem('uuid') || '';
    console.log(this.newStore);
  }

  openAddToStoreModal(content: TemplateRef<any>, isbn: string) {
    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' });
    this.newStore.bookIsbn = isbn;
  }

  confirmAddToStore(cantidad: number, precio: number) {
    this.newStore.shopUuid = localStorage.getItem('uuid') || '';
    this.newStore.cantidad = cantidad;
    this.newStore.precio = precio;
    console.log(this.newStore);
  }

  openEditBookModal(content: TemplateRef<any>, book: AllBooks) {
    // Asigna el libro seleccionado a editBookData
    this.editBookData = { ...book };
    // Asigna el ISBN del libro seleccionado a una propiedad en tu componente
    this.editBookData.isbn = book.isbn;
    this.editBookData.uuid = localStorage.getItem('uuid');
    // Abre el modal de edición
    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then(
      (result) => {
        this.closeResult = `Closed with: ${result}`;
      },
      (reason) => {
        this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
      },
    );
  }

  confirmEdit(content: TemplateRef<any>, editedBook: EditBook) {
    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then(
      (result) => {
        if (result === 'confirm') {
          this.editBook(this.editBookData.isbn, editedBook).subscribe(
            response => {
              console.log('Libro editado:', response);
              this.modalService.dismissAll();
            },
            error => {
              console.error('Error al editar el libro:', error);
            }
          );
        }
      },
      (reason) => {
        console.log(`Modal dismissed with: ${reason}`);
      }
    );
  }
  editBook(isbn: string, editBook: EditBook): Observable<EditBook> {
    return this.bookService.editBook(isbn, editBook);
  }






}
