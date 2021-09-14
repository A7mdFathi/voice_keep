import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/utils/app_routes.dart';
import 'package:flutter_procrew/utils/app_routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'business_logic/auth/authentication_bloc.dart';
import 'dependencies/dependency_init.dart';

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      lazy: false,
      create: (_) =>
          getIt<AuthenticationBloc>()..add(AuthenticationAppStarted()),
      child: ScreenUtilInit(
        designSize: Size(360, 730),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Booking App',
          initialRoute: AppRoutesName.SPLASH_SCREEN,
          onGenerateRoute: AppRoutes.onGeneratedRoutes,
        ),
      ),
    );
  }
}
