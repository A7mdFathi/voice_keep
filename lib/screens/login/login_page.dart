import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/login_cubit/login_cubit.dart';
import 'package:flutter_procrew/dependencies/dependency_init.dart';
import 'package:flutter_procrew/repository/authentication_repository.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => LoginCubit(getIt<AuthenticationRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
