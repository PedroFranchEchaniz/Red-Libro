import { Component, OnInit } from '@angular/core';
import { BookServiceService } from '../../../service/book-service.service';
import { BookingServiceService } from '../../../service/booking-service.service';
import { Booking, BookingResponse } from '../../../models/shopBookings.interface';

@Component({
  selector: 'app-booking',
  templateUrl: './booking.component.html',
  styleUrl: './booking.component.css'
})
export class BookingComponent implements OnInit {

  bookings!: Booking[];
  page!: number;

  constructor(private bookingService: BookingServiceService) { }

  ngOnInit(): void {
    this.getbooking()
  }

  getbooking() {
    this.bookingService.getBookingShop(0).subscribe(resp => {
      this.bookings = resp.content;
    })
  }

  deleteBooking(uuid: string, bookIsbn: string) {
    const shopUuid = localStorage.getItem('uuid');
    this.bookingService.deleteBooking(uuid, bookIsbn, shopUuid!).subscribe(
      () => {
        // Manejar la respuesta exitosa, por ejemplo, actualizar la lista de reservas
        this.getbooking();
      },
      error => {
        // Manejar el error, si es necesario
        console.error('Error al eliminar la reserva', error);
      }
    );
  }

}
