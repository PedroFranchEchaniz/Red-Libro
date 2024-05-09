import { Component, OnInit } from '@angular/core';
import { AccountServiceService } from '../../service/AccountService/account-service.service';
import { Router } from '@angular/router';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrls: ['./login-page.component.css']
})
export class LoginPageComponent implements OnInit {
  username = '';
  password = '';
  errorMessage = '';  // Variable para almacenar el mensaje de error

  constructor(private accountService: AccountServiceService, private router: Router) { }

  ngOnInit(): void {

    let token = localStorage.getItem('token');
    console.log(token);
    if (token) {
      this.router.navigateByUrl('/listBook');
    }
  }

  login() {
    this.accountService.loginAccount(this.username, this.password).subscribe({
      next: (response) => {
        localStorage.setItem('token', response.token);  // Asegúrate de que response.token y response.id son correctos
        localStorage.setItem('uuid', response.id.toString());  // Convierte a string si necesario
        this.router.navigateByUrl('/listBook');
      },
      error: (error: HttpErrorResponse) => {
        if (error.status === 401) {
          this.errorMessage = 'Username or Password is incorrect';
        } else {
          this.errorMessage = 'An error occurred. Please try again later.';
        }
      }
    });
  }



}
