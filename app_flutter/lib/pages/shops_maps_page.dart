import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/models/response/shops_with_book_response.dart';

class ShopsMapPage extends StatelessWidget {
  final List<ShopsWithBookResponse> shops;
  final Book book;

  const ShopsMapPage({Key? key, required this.shops, required this.book})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.titulo ?? 'Sin título'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
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
                                    title: shop.name, snippet: shop.direccion),
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
                        return ListTile(
                          title: Text(shop.name!,
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text(shop.direccion!,
                              style: TextStyle(color: Colors.white70)),
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
    );
  }
}
