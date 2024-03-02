import 'package:app_flutter/models/response/confirm_booking_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/models/response/shops_with_book_response.dart';
import 'package:app_flutter/blocs/booking-bloc/bloc/booking_bloc.dart';

class ShopsMapPage extends StatefulWidget {
  final List<ShopsWithBookResponse> shops;
  final Book book;

  const ShopsMapPage({Key? key, required this.shops, required this.book})
      : super(key: key);

  @override
  _ShopsMapPageState createState() => _ShopsMapPageState();
}

class _ShopsMapPageState extends State<ShopsMapPage> {
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _updateMarkers();
  }

  void _showBookingConfirmationDialog(ConfirmBookingResponse bookingResponse) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Reserva Confirmada'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 48),
              Text('Tu reserva ha sido confirmada.'),
              Text('Código de reserva: ${bookingResponse.codigo}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }

  void _updateMarkers([String? selectedShopUuid]) {
    setState(() {
      _markers = selectedShopUuid == null
          ? widget.shops
              .map((shop) => Marker(
                    markerId: MarkerId(shop.uuid!),
                    position: LatLng(
                        double.parse(shop.lat!), double.parse(shop.lon!)),
                    infoWindow:
                        InfoWindow(title: shop.name, snippet: shop.direccion),
                  ))
              .toSet()
          : {
              widget.shops
                  .where((shop) => shop.uuid == selectedShopUuid)
                  .map((shop) => Marker(
                        markerId: MarkerId(shop.uuid!),
                        position: LatLng(
                            double.parse(shop.lat!), double.parse(shop.lon!)),
                        infoWindow: InfoWindow(
                            title: shop.name, snippet: shop.direccion),
                      ))
                  .first
            };
    });
  }

  void _showConfirmReservationDialog(
      BuildContext context, String shopUuid, String bookIsbn) {
    final storage = FlutterSecureStorage();

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
                final clientUuid = await storage.read(key: 'uuid');
                if (clientUuid != null) {
                  BlocProvider.of<BookingBloc>(context).add(
                    ConfirmBookingEvent(shopUuid, bookIsbn, clientUuid),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error: UUID del usuario no encontrado.")));
                }
                Navigator.of(dialogContext).pop();
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
        title: Text(widget.book.titulo ?? 'Sin título'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingLoad) {
            _showBookingConfirmationDialog(state.booking);
          } else if (state is BookingError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(double.parse(widget.shops.first.lat ?? '0'),
                      double.parse(widget.shops.first.lon ?? '0')),
                  zoom: 14,
                ),
                markers: _markers,
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Container(
                  height: 150,
                  color: Colors.black.withOpacity(0.5),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.shops.length,
                    itemBuilder: (context, index) {
                      final shop = widget.shops[index];
                      return GestureDetector(
                        onTap: () => _updateMarkers(shop.uuid),
                        child: Container(
                          width: 250,
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(shop.name!,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                  Text(shop.direccion!,
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 14)),
                                  TextButton(
                                    onPressed: () =>
                                        _showConfirmReservationDialog(context,
                                            shop.uuid!, widget.book.isbn!),
                                    child: Text('Reservar'),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        primary: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
