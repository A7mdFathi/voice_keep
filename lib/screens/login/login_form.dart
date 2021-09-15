import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/login_cubit/login_cubit.dart';
import 'package:flutter_procrew/business_logic/show_password/show_password_cubit.dart';
import 'package:flutter_procrew/dependencies/dependency_init.dart';
import 'package:flutter_procrew/utils/app_routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Authentication failure'),
              ),
            );
        }
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Authentication Success'),
              ),
            );
          Navigator.pushReplacementNamed(context, AppRoutesName.HOME_SCREEN);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image.asset(
            //   'assets/bloc_logo_small.png',
            //   height: 120,
            // ),
            SizedBox(height: 16.h),
            const _EmailInput(),
            SizedBox(height: 8.h),
            const _PasswordInput(),
            SizedBox(height: 8.h),
            const _LoginButton(),
            SizedBox(height: 8.h),
            const _GoogleLoginButton(),
            const _FacebookLoginButton(),
            SizedBox(height: 4.h),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                borderSide: BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8.r,
              ),
            ),
            labelText: 'Email',
            labelStyle: TextStyle(
              color: Colors.blue,
            ),
            errorText: state.password.invalid ? 'invalid email' : null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.all(8.r),
            prefixIcon: Container(
              color: Colors.blue,
              width: 50.w,
              margin: EdgeInsets.only(right: 15.w),
              child: const Icon(
                Icons.password_rounded,
                color: Colors.white,
              ),
            ),
            isDense: true,
          ),
          keyboardType: TextInputType.visiblePassword,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: !context.watch<ShowPasswordCubit>().state,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                borderSide: BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8.r,
              ),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.blue,
            ),
            errorText: state.password.invalid ? 'invalid password' : null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.all(8.r),
            prefixIcon: Container(
              color: Colors.blue,
              width: 50.w,
              margin: EdgeInsets.only(right: 15.w),
              child: const Icon(
                Icons.password_rounded,
                color: Colors.white,
              ),
            ),
            suffixIcon: ShowPasswordWidget(),
            isDense: true,
          ),
          keyboardType: TextInputType.visiblePassword,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: state.status.isSubmissionInProgress
                      ? const CircleBorder()
                      : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                  fixedSize: Size(110.w, 50.h),
                  elevation: 5.0,
                ),
                key: const Key('loginForm_continue_raisedButton'),
                child: state.status.isSubmissionInProgress
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Signin'),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: theme.colorScheme.secondary,
      ),
    );
  }
}

class _FacebookLoginButton extends StatelessWidget {
  const _FacebookLoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_facebookLogin_raisedButton'),
      onPressed: () => context.read<LoginCubit>().logInWithFacebook(),
      icon: const Icon(FontAwesomeIcons.facebook, color: Colors.white),
      label: const Text(
        'SIGN IN WITH FACEBOOK',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: theme.colorScheme.secondary,
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () =>
          Navigator.pushNamed(context, AppRoutesName.SIGNUP_SCREEN),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}

class ShowPasswordWidget extends StatelessWidget {
  const ShowPasswordWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShowPasswordCubit>(),
      child: IconButton(
        onPressed: () =>
            context.read<ShowPasswordCubit>().showPasswordToState(),
        icon: Builder(
          builder: (context) {
            final bool _shwPass = context.watch<ShowPasswordCubit>().state;
            return Icon(
              !_shwPass ? Icons.visibility_off_rounded : Icons.visibility,
              color: Colors.blue,
            );
          },
        ),
      ),
    );
  }
}
