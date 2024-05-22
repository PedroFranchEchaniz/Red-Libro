import { Component, OnInit, TemplateRef, inject } from '@angular/core';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { BookServiceService } from '../../../service/book-service.service';
import { AllBooks } from '../../../models/allBooks.interface';
import { ModalDismissReasons, NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { debounceTime } from 'rxjs/operators';
import { newBook } from '../../../models/newBook.interface';

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
  selectedGenres: string[] = [];
  availableGenres: string[] = ['Ficción', 'No ficción', 'Drama', 'Misterio', 'Romance', 'Aventura', 'Fantasia', 'Ciencia ficción', 'Thriller', 'Terror', 'Biografía', 'Autobiografía', 'Poesía', 'Ensayo', 'Historia'];
  imagePreview: string | ArrayBuffer | null = null;

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

    // Formatear la fecha como "YYYY-MM-DD"
    const año = fechaActual.getFullYear();
    const mes = ('0' + (fechaActual.getMonth() + 1)).slice(-2); // Agregar 0 al mes si es necesario y obtener los últimos dos dígitos
    const dia = ('0' + fechaActual.getDate()).slice(-2); // Agregar 0 al día si es necesario y obtener los últimos dos dígitos
    const fechaFormateada = `${año}-${mes}-${dia}`;

    // Asignar la fecha formateada al campo "fecha" de tu objeto "newBook"
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
}
