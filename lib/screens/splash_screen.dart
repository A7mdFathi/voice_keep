import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/auth/authentication_bloc.dart';
import 'package:flutter_procrew/utils/app_routes_name.dart';

import 'login/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => LoginPage()), (r) => true);
        } else if (state is AuthenticationStateAuthenticated) {
          Navigator.of(context).pushNamed(AppRoutesName.HOME_SCREEN);
        }
      },
      child: Scaffold(
          body: Container(
        child: Center(
          child: Text('Splash Screen'),
        ),
      )),
    );
  }
}
