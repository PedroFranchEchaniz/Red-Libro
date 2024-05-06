import { Component, OnInit } from '@angular/core';
import { AccountServiceService } from '../../service/AccountService/account-service.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrl: './login-page.component.css'
})
export class LoginPageComponent implements OnInit {

  username = '';
  password = '';
  rol: string[] = [];
  id = '';

  constructor(private accountService: AccountServiceService, private router: Router,) { }

  ngOnInit(): void {
    localStorage.clear();

    let token = localStorage.getItem('token');

    if (token != null) {
      this.router.navigateByUrl('/home');
    }
  }

  login() {
    this.accountService.loginAccount(this.username, this.password).subscribe(() => {
      this.router.navigateByUrl('/books');
    })
  }
}
