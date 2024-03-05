import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/blocs/User-loged-bloc/bloc/loges_user_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LogesUserBloc>(context).add(FetchUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Información del Usuario"),
        backgroundColor: Colors.black, // Fondo del AppBar en negro.
      ),
      backgroundColor: Colors.black, // Fondo de la pantalla en negro.
      body: BlocBuilder<LogesUserBloc, LogesUserState>(
        builder: (context, state) {
          if (state is UsearLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final user = state.user;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: user.avatar ?? '',
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person,
                            size: 120, color: Colors.white);
                      },
                    ).image,
                  ),
                  SizedBox(height: 20),
                  Text('Nombre: ${user.name ?? "No disponible"}',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  Text('Apellido: ${user.lastName ?? "No disponible"}',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  Text('Usuario: ${user.username ?? "No disponible"}',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 20),
                  Text('Reservas',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: user.booking?.length ?? 0,
                      itemBuilder: (context, index) {
                        final reserva = user.booking![index];
                        return Card(
                          color: Colors.grey[850],
                          elevation: 4,
                          child: Container(
                            width: 180,
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    reserva.portada ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset('/images/image.png',
                                          fit: BoxFit.cover);
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  reserva.titulo ?? "Sin título",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Fecha Reserva: ${reserva.fechaReserva ?? "N/A"}',
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Fecha Expiración: ${reserva.fechaExpiacion ?? "N/A"}',
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Estantes',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: user.shelving?.length ?? 0,
                      itemBuilder: (context, index) {
                        final estante = user.shelving![index];
                        return Card(
                          color: Colors.grey[850],
                          elevation: 4,
                          child: Container(
                            width: 180,
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    estante.portada ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/image.png',
                                          fit: BoxFit.cover);
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  estante.titulo ?? "Sin título",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Autor: ${estante.autor ?? "Desconocido"}',
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Valoración: ${estante.valoracionMedia?.toString() ?? "N/A"}',
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
            );
          } else if (state is UserError) {
            return Center(
                child: Text('Error: ${state.message}',
                    style: TextStyle(color: Colors.white)));
          }
          return Center(
              child: Text('Cargando información del usuario...',
                  style: TextStyle(color: Colors.white)));
        },
      ),
    );
  }
}
