import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/blocs/User-loged-bloc/bloc/loges_user_bloc.dart';
import 'package:transparent_image/transparent_image.dart'; // Asegúrate de tener este paquete

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
      ),
      body: BlocBuilder<LogesUserBloc, LogesUserState>(
        builder: (context, state) {
          if (state is UsearLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final user = state.user;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: FadeInImage.memoryNetwork(
                      placeholder:
                          kTransparentImage, // Un placeholder transparente
                      image: user.avatar ?? '',
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        // Puedes definir aquí un widget alternativo en caso de error
                        // Por ejemplo, un icono o imagen codificada en base64
                        return Icon(Icons.person,
                            size: 120); // Un icono como placeholder
                      },
                    ).image,
                  ),
                  SizedBox(height: 20),
                  Text('Nombre: ${user.name ?? "No disponible"}'),
                  SizedBox(height: 10),
                  Text('Apellido: ${user.lastName ?? "No disponible"}'),
                  SizedBox(height: 10),
                  Text('Usuario: ${user.username ?? "No disponible"}'),
                ],
              ),
            );
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('Cargando información del usuario...'));
        },
      ),
    );
  }
}
