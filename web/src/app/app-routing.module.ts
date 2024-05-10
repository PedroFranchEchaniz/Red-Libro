import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginPageComponent } from './ui/login-page/login-page.component';
import { ListBookComponent } from './ui/books/list-book/list-book.component';
import { ListBooksInAplicacitionComponent } from './ui/books/list-books-in-aplicacition/list-books-in-aplicacition.component';
import { BookingComponent } from './ui/books/booking/booking.component';

const routes: Routes = [

  { path: 'booking', component: BookingComponent },
  { path: 'books', component: ListBooksInAplicacitionComponent },
  { path: 'listBook', component: ListBookComponent },
  { path: 'login', component: LoginPageComponent },
  { path: '', redirectTo: '/login', pathMatch: 'full' },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
