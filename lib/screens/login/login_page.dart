import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_keep/business_logic/login_cubit/login_cubit.dart';
import 'package:voice_keep/business_logic/show_password/show_password_cubit.dart';
import 'package:voice_keep/dependencies/dependency_init.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<LoginCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<ShowPasswordCubit>(),
          )
        ],
        child: const LoginForm(),
      ),
    );
  }
}
