import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/blocs/User-loged-bloc/bloc/loges_user_bloc.dart';

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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                    backgroundImage:
                        user.avatar != null && user.avatar!.isNotEmpty
                            ? NetworkImage(user.avatar!)
                            : AssetImage('assets/images/image.png')
                                as ImageProvider,
                  ),
                  SizedBox(height: 20),
                  Text('${user.name ?? "No disponible"}',
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                  SizedBox(height: 10),
                  Text(' ${user.lastName ?? "No disponible"}',
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                  SizedBox(height: 10),
                  Text('${user.username ?? "No disponible"}',
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                  SizedBox(height: 20),
                  Text('Reservas',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0))),
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
                          color: const Color.fromARGB(255, 0, 0, 0))),
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
