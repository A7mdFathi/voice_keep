import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic/auth/authentication_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AppStatus.unauthenticated) {
          print('SPLASH BLOC LISTEN');
        } else if (state.status == AppStatus.unauthenticated) {
          print('SPLASH BLOC LISTEN');
        }
      },
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Pro Crew ',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 45.sp,
            ),
            textAlign: TextAlign.center,
          ),
          const Center(child: CircularProgressIndicator()),
          SizedBox(height: 12.h),
        ],
      )),
    );
  }
}
