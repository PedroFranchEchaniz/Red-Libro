import { Component, OnInit, TemplateRef, inject } from '@angular/core';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { BookServiceService } from '../../../service/book-service.service';
import { AllBooks } from '../../../models/allBooks.interface';
import { ModalDismissReasons, NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { debounceTime } from 'rxjs/operators';
import { newBook } from '../../../models/newBook.interface';
import { Store } from '../../../models/getStore.interface';
import { newStore } from '../../../models/adToStore.interface';
import { EditBook } from '../../../models/editBook.interface';
import { Observable } from 'rxjs';
import { book } from 'ngx-bootstrap-icons';
import { HttpClient } from '@angular/common/http';
import { AllStoreDto } from '../../../models/allStoreDtoResponse.interface';


@Component({
  selector: 'app-list-books-in-aplicacition',
  templateUrl: './list-books-in-aplicacition.component.html',
  styleUrls: ['./list-books-in-aplicacition.component.css']
})
export class ListBooksInAplicacitionComponent implements OnInit {



  books!: AllBooks[];
  storeBooks!: Store[];
  allStoreBooks: AllStoreDto[] = [];
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
    mediaValoracion: 0,
    stock: 0
  };
  newStore: newStore = { bookIsbn: '', shopUuid: '', cantidad: 0, precio: 0 };
  selectedGenres: string[] = [];
  availableGenres: string[] = ['Fantasia', 'Policiaca', 'Aventuras', 'Misterio', 'Cienciaficcion', 'Ficcion', 'NoFiccion', 'Drama', 'Romance', 'Thriller', 'Terror', 'Biografía', 'Autobiografía', 'Poesía', 'Ensayo', 'Historia'];
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

  activeModal: NgbModalRef | undefined;

  constructor(private fb: FormBuilder, private bookService: BookServiceService, private storeService: StoreServiceService) { }

  ngOnInit() {
    this.getAllBooks();
    this.getStoreBooks();
    this.getAllBooks();
    this.bookForm = this.fb.group({
      filter: ['']
    });

    this.bookForm.get('filter')?.valueChanges.pipe(
      debounceTime(300)
    ).subscribe(value => {
      this.filteredBooks = this.filterBooks(value);
    });

  }

  getAllBooks() {
    this.bookService.getAllBooks().subscribe(resp => {
      this.books = resp;
      this.filteredBooks = resp;
    });
  }

  getStoreBooks() {
    const uuid = localStorage.getItem('uuid');
    if (uuid) {
      this.storeService.getStoresByShopUuid(uuid, 0).subscribe(resp => {
        this.storeBooks = resp.content;
        this.getAllStoreBooks();
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

  getAllStoreBooks() {
    const uuid = localStorage.getItem('uuid');
    if (uuid) {
      this.storeService.getAllStoreByShopUuid(uuid).subscribe(
        (resp: AllStoreDto[]) => {
          this.allStoreBooks = resp;
        },
        error => {
          console.error('Error fetching store books:', error);
        }
      );
    }
  }

  bookInStore(isbn: string): boolean {
    return this.allStoreBooks.some(storeBook => storeBook.isbn === isbn);
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
    this.activeModal = this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' });

    this.activeModal.result.then(
      (result) => {
        this.closeResult = `Closed with: ${result}`;
      },
      (reason) => {
        this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
      }
    );
  }

  onFileSelected(event: any) {
    const file: File = event.target.files[0];
    this.selectedFile = file;

    // Mostrar vista previa de la imagen seleccionada
    const reader = new FileReader();
    reader.onload = () => {
      this.imagePreview = reader.result;
    };
    reader.readAsDataURL(file);
  }

  selectedFile: File | null = null;


  saveBook() {
    const formData = new FormData();
    const fechaActual = new Date();
    const año = fechaActual.getFullYear();
    const mes = ('0' + (fechaActual.getMonth() + 1)).slice(-2);
    const dia = ('0' + fechaActual.getDate()).slice(-2);
    const fechaFormateada = `${año}-${mes}-${dia}`;

    if (this.selectedFile) {
      formData.append('file', this.selectedFile);
      this.newBook.portda = this.selectedFile.name;
    }

    formData.append('ISBN', this.newBook.ISBN);
    formData.append('titulo', this.newBook.titulo);
    formData.append('autor', this.newBook.autor);
    formData.append('editorial', this.newBook.editorial);
    formData.append('fecha', fechaFormateada);

    this.selectedGenres.forEach(genre => {
      formData.append('genres', genre);
    });

    formData.append('resumen', this.newBook.resumen);
    formData.append('mediaValoracion', this.newBook.mediaValoracion.toString());
    formData.append('stock', '0');

    this.bookService.newBook(formData).subscribe(
      response => {
        console.log('Book saved successfully!', response);
        if (this.activeModal) {
          this.activeModal.close(); // Close the modal after saving
        }
        this.getAllBooks();
      },
      error => {
        console.error('Error saving book:', error);
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

    this.storeService.addToStore(this.newStore).subscribe(
      response => {
        console.log('Store added successfully', response);
      },
      error => {
        console.error('Error adding to store', error);
      }
    );
  }


  openEditBookModal(content: TemplateRef<any>, book: AllBooks) {
    if (!book) {
      this.editBookData = {
        titulo: '',
        autor: '',
        editorial: '',
        resumen: '',
        fecha: '',
        genres: [],
        uuid: ''
      };
    } else {
      this.editBookData = { ...book };

      if (typeof this.editBookData.genres === 'string') {
        this.editBookData.genres = JSON.parse(this.editBookData.genres);
      }

      this.editBookData.isbn = book.isbn;
      this.editBookData.uuid = localStorage.getItem('uuid');
    }

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
    if (!editedBook.genres || editedBook.genres.length === 0) {
      editedBook.genres = this.bookSelected.genres ? this.bookSelected.genres : [];
    } else {
      editedBook.genres = editedBook.genres.filter(genre => typeof genre === 'string' && genre.trim() !== '');
    }

    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then(
      (result) => {
        if (result === 'confirm') {
          this.editBook(this.editBookData.isbn, editedBook).subscribe(
            response => {
              console.log('Libro editado:', response);
              this.modalService.dismissAll();
              this.getAllBooks();
              this.getStoreBooks();
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







