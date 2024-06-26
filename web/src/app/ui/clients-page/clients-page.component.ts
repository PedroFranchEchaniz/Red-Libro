import { Component, OnInit } from '@angular/core';
import { AccountServiceService } from '../../service/AccountService/account-service.service';
import { AllClientsDto, GetAllClientsResponse } from '../../models/allClientsResponse.interface';

@Component({
  selector: 'app-clients-page',
  templateUrl: './clients-page.component.html',
  styleUrls: ['./clients-page.component.css']
})
export class ClientsPageComponent implements OnInit {
  page: number = 0;
  totalPages: number = 1;
  clients!: AllClientsDto[];
  client!: AllClientsDto;

  constructor(private accountServiceService: AccountServiceService) { }

  ngOnInit() {
    this.allClients();
  }

  allClients() {
    this.accountServiceService.getclients(this.page).subscribe(
      (resp: GetAllClientsResponse) => {
        console.log(resp);
        this.clients = resp
      },
      (error) => {
        console.error('Error fetching clients:', error);
      }
    );
  }

  changePage(newPage: number) {
    if (newPage >= 0 && newPage < this.totalPages) {
      this.page = newPage;
      this.allClients();
    }
  }

  toggleBann(uuid: string) {
    this.accountServiceService.toogleBann(uuid).subscribe(
      (resp: AllClientsDto) => {
        console.log(resp);
        this.client = resp;
        this.allClients();
      },
      (error) => {
        console.error('Error fetching clients:', error);
      }
    );

  }
}
