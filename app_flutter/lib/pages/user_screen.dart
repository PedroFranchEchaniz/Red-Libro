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
    // Dispara el evento FetchUser para cargar la información del usuario
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
            // Asegúrate de ajustar el acceso a los datos del usuario según tu modelo de datos
            return Center(child: Text('Usuario: ${state.user.name}'));
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('Pulse el botón de usuario'));
        },
      ),
    );
  }
}
