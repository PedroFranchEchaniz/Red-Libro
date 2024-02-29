import 'package:app_flutter/models/response/confirm_booking_response.dart';
import 'package:flutter/material.dart';

class BookingConfirmationPage extends StatelessWidget {
  final ConfirmBookingResponse bookingResponse;

  const BookingConfirmationPage({Key? key, required this.bookingResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmación de Reserva'),
      ),
      body: Center(
        child: Text('Reserva confirmada: ${bookingResponse.codigo}'),
      ),
    );
  }
}
