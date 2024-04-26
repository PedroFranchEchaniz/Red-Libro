import { Component, OnInit } from '@angular/core';
import { AccountService } from '../../services/account.service';
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

  constructor(private accountService: AccountService, private router: Router) { }

  ngOnInit(): void {
    localStorage.clear();

    let token = localStorage.getItem('token');

    if (token != null) {

    }
  }
  /* 
   username = '';
   password = '';
   rol: string[] = [];
   id = '';
 */



  login() {
    this.accountService.loginAccount(this.username, this.password).subscribe(resp => {
      localStorage.setItem('account_id', resp.id);
      localStorage.setItem('token', resp.token);
      this.rol = resp.roles;
      this.id = resp.id;

      this.router.navigateByUrl('/home');
    })
  }

  goToRegister() {
    this.router.navigateByUrl('/register');
  }


}
