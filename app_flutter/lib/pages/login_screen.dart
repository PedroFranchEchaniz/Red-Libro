import 'package:app_flutter/repositories/auth/auth_repositori.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/blocs/bloc/login_bloc.dart';
import 'package:app_flutter/repositories/auth/auth_repository_impl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formLogin = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  late LoginBloc _loginBloc;
  late AuthRepository authRepository;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    super.initState();
    _loginBloc = LoginBloc(authRepository);
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is DoLoginSuccess) {
              // Implementar navegación a otra pantalla tras el login exitoso
              // Ejemplo: Navigator.of(context).pushReplacementNamed('/home');
            } else if (state is DoLoginError) {
              // Mostrar mensaje de error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            if (state is DoLoginLoadin) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildLoginForm(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formLogin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: userTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passTextController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formLogin.currentState!.validate()) {
                  _loginBloc.add(DoLoginEvent(
                    userTextController.text,
                    passTextController.text,
                  ));
                }
              },
              child: const Text('LOGIN'),
            ),
          ),
        ],
      ),
    );
  }
}
