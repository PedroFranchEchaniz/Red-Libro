// shops_map_page.dart
import 'package:app_flutter/models/response/shops_with_book_response.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopsMapPage extends StatelessWidget {
  final List<ShopsWithBookResponse> shops;

  const ShopsMapPage({Key? key, required this.shops}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mapa de Tiendas')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              double.parse(shops.first.lat!), double.parse(shops.first.lon!)),
          zoom: 14,
        ),
        markers: shops
            .map((shop) => Marker(
                  markerId: MarkerId(shop.name!),
                  position:
                      LatLng(double.parse(shop.lat!), double.parse(shop.lon!)),
                  infoWindow:
                      InfoWindow(title: shop.name, snippet: shop.direccion),
                ))
            .toSet(),
      ),
    );
  }
}
