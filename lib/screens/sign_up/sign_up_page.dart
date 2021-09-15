import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/show_password/show_password_cubit.dart';
import 'package:flutter_procrew/business_logic/signup_cubit/sign_up_cubit.dart';
import 'package:flutter_procrew/dependencies/dependency_init.dart';

import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpCubit>(
            create: (_) => getIt<SignUpCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<ShowPasswordCubit>(),
          )
        ],
        child: const SignUpForm(),
      ),
    );
  }
}
