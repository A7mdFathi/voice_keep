import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voice_keep/business_logic/login_cubit/login_cubit.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        fixedSize: Size(200.w, 50.h),
        primary: theme.colorScheme.secondary,
      ),
    );
  }
}

class FacebookLoginButton extends StatelessWidget {
  const FacebookLoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      onPressed: () => null,
      icon: const Icon(FontAwesomeIcons.facebook, color: Colors.white),
      label: const Text(
        'SIGN IN WITH FACEBOOK',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        fixedSize: Size(200.w, 50.h),
        primary: theme.colorScheme.secondary,
      ),
    );
  }
}
