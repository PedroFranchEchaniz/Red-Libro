import 'package:app_flutter/blocs/booking-bloc/bloc/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/models/response/shops_with_book_response.dart';
import 'package:app_flutter/pages/booking_confirmation_page.dart';

class ShopsMapPage extends StatelessWidget {
  final List<ShopsWithBookResponse> shops;
  final Book book;

  const ShopsMapPage({Key? key, required this.shops, required this.book})
      : super(key: key);

  void _showConfirmReservationDialog(
      BuildContext context, String shopUuid, String bookIsbn) {
    final storage = FlutterSecureStorage(); // Instancia de FlutterSecureStorage

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirmar Reserva'),
          content: Text('¿Deseas reservar el libro en esta tienda?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () async {
                final clientUuid =
                    await storage.read(key: 'uuid'); // Lee el uuid almacenado
                if (clientUuid != null) {
                  BlocProvider.of<BookingBloc>(context).add(
                    ConfirmBookingEvent(shopUuid, bookIsbn, clientUuid),
                  );
                } else {
                  // Manejar el caso en que no se encuentre el uuid, si es necesario
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error: UUID del usuario no encontrado.")));
                }
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.titulo ?? 'Sin título'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingLoad) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    BookingConfirmationPage(bookingResponse: state.booking),
              ),
            );
          } else if (state is BookingError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  book.portada ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: [0.5, 0.9],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    Container(
                      height: 250,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(shops.first.lat!),
                              double.parse(shops.first.lon!)),
                          zoom: 14,
                        ),
                        markers: shops
                            .map((shop) => Marker(
                                  markerId: MarkerId(shop.name!),
                                  position: LatLng(double.parse(shop.lat!),
                                      double.parse(shop.lon!)),
                                  infoWindow: InfoWindow(
                                      title: shop.name,
                                      snippet: shop.direccion),
                                ))
                            .toSet(),
                      ),
                    ),
                    Container(
                      height: 250,
                      child: ListView.builder(
                        itemCount: shops.length,
                        itemBuilder: (context, index) {
                          final shop = shops[index];
                          return Card(
                            color: Colors.black54,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(shop.name!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                        Text(shop.direccion!,
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text('${shop.precio} €',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        textAlign: TextAlign.center),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          _showConfirmReservationDialog(
                                              context, shop.uuid!, book.isbn!),
                                      child: Text('Reservar'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          onPrimary: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
