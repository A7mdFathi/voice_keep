import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_keep/utils/app_routes_name.dart';

import 'business_logic/auth/authentication_bloc.dart';
import 'dependencies/dependency_init.dart';
import 'utils/app_routes.dart';

class App extends StatelessWidget {
  App({
    Key key,
  }) : super(key: key);
  AuthenticationBloc _authenticationBloc = getIt<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (_) => _authenticationBloc,
      child: ScreenUtilInit(
        designSize: Size(360, 730),
        builder: () => AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    Key key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'Voice Keep App',
      initialRoute: AppRoutesName.SPLASH_SCREEN,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          // bloc: _authenticationBloc,
          listener: (context, state) {
            print('state:${state.status}');

            switch (state.status) {
              case AppStatus.authenticated:
                print(' NAVIGATOR IS IN HOME SCREEN');
                _navigator.pushNamedAndRemoveUntil<void>(
                  AppRoutesName.HOME_SCREEN,
                  (route) => false,
                );

                break;
              case AppStatus.unauthenticated:
                print(' NAVIGATOR IS IN Login SCREEN');
                _navigator.pushNamedAndRemoveUntil<void>(
                  AppRoutesName.LOGIN_SCREEN,
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: AppRoutes.onGeneratedRoutes,
    );
  }
}
