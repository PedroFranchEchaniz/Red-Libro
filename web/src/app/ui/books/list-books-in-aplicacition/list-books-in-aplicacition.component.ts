import { Component, OnInit } from '@angular/core';
import { StoreServiceService } from '../../../service/AccountService/store-service.service';
import { BookServiceService } from '../../../service/book-service.service';
import { AllBooks } from '../../../models/allBooks.interface';

@Component({
  selector: 'app-list-books-in-aplicacition',
  templateUrl: './list-books-in-aplicacition.component.html',
  styleUrl: './list-books-in-aplicacition.component.css'
})
export class ListBooksInAplicacitionComponent implements OnInit {



  books!: AllBooks[];
  constructor(private bookService: BookServiceService) { }

  ngOnInit() {
    this.getAllBooks();
  }

  getAllBooks() {
    this.bookService.getAllBooks().subscribe(resp => {
      this.books = resp;
    })
  }

  showInfo() {
    console.log('Hola');
  }

}
