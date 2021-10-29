import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_keep/business_logic/notes_list_bloc/note_list_bloc.dart';
import 'package:voice_keep/business_logic/send_voice/voice_message_cubit.dart';
import 'package:voice_keep/dependencies/dependency_init.dart';
import 'package:voice_keep/screens/home_screen.dart';
import 'package:voice_keep/screens/login/login_page.dart';
import 'package:voice_keep/screens/sign_up/sign_up_page.dart';
import 'package:voice_keep/screens/splash_screen.dart';

import 'app_routes_name.dart';

class AppRoutes {
  static Route<dynamic> onGeneratedRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutesName.SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutesName.LOGIN_SCREEN:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case AppRoutesName.SIGNUP_SCREEN:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case AppRoutesName.HOME_SCREEN:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => getIt<VoiceMessageCubit>()),
                    BlocProvider(create: (_) => getIt<NoteListBloc>()),
                  ],
                  child: HomeScreen(),
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error Route'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      ),
    );
  }
}
