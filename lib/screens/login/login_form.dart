import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/login_cubit/login_cubit.dart';
import 'package:flutter_procrew/business_logic/show_password/show_password_cubit.dart';
import 'package:flutter_procrew/repository/authentication_repository.dart';
import 'package:flutter_procrew/utils/app_routes_name.dart';
import 'package:flutter_procrew/widgets/social_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(
          top: 30.h,
          left: 12.w,
          right: 12.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
                child: Text(
                  'Voice keep',
                  style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              SizedBox(height: 18.h),
              _EmailInput(),
              SizedBox(height: 18.h),
              _PasswordInput(),
              SizedBox(height: 18.h),
              _LoginButton(),
              SizedBox(height: 18.h),
              GoogleLoginButton(
                login_type: LOGIN_TYPE.login,
              ),
              SizedBox(height: 18.h),
              FacebookLoginButton(),
              SizedBox(height: 18.h),
              _SignUpButton(),
              SizedBox(height: 18.h),
            ],
          ),
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
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          textInputAction: TextInputAction.next,
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
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(8.r))),
              width: 50.w,
              margin: EdgeInsets.only(right: 15.w),
              child: const Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
            isDense: true,
          ),
          keyboardType: TextInputType.emailAddress,
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
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(8.r))),
              width: 50.w,
              margin: EdgeInsets.only(right: 15.w),
              child: const Icon(
                Icons.password_rounded,
                color: Colors.white,
              ),
            ),
            suffixIcon: buildButton(context),
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
                    ? const CircularProgressIndicator(
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

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () =>
          Navigator.pushReplacementNamed(context, AppRoutesName.SIGNUP_SCREEN),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}

buildButton(BuildContext context) {
  return IconButton(
    onPressed: () => context.read<ShowPasswordCubit>().showPasswordToState(),
    icon: Builder(
      builder: (context) {
        final bool _shwPass = context.watch<ShowPasswordCubit>().state;
        return Icon(
          !_shwPass ? Icons.visibility_off_rounded : Icons.visibility,
          color: Colors.blue,
        );
      },
    ),
  );
}
