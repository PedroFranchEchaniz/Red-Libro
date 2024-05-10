import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { LoginPageComponent } from './ui/login-page/login-page.component';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { ListBookComponent } from './ui/books/list-book/list-book.component';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { ListBooksInAplicacitionComponent } from './ui/books/list-books-in-aplicacition/list-books-in-aplicacition.component';
import { RouterLink } from '@angular/router';

@NgModule({
  declarations: [
    AppComponent,
    LoginPageComponent,
    ListBookComponent,
    NavBarComponent,
    ListBooksInAplicacitionComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgbModule,
    HttpClientModule,
    FormsModule,
    RouterLink
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
