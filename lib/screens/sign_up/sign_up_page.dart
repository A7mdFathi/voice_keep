import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/signup_cubit/sign_up_cubit.dart';
import 'package:flutter_procrew/dependencies/dependency_init.dart';
import 'package:flutter_procrew/repository/authentication_repository.dart';

import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(getIt<AuthenticationRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
