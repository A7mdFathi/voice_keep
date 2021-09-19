import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/show_password/show_password_cubit.dart';
import 'package:flutter_procrew/business_logic/signup_cubit/sign_up_cubit.dart';
import 'package:flutter_procrew/screens/login/login_form.dart';
import 'package:flutter_procrew/utils/app_routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 30.h,
          left: 12.w,
          right: 12.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Text(
                'Signup',
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
                child: Text(
                  'Pro Crew App',
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
              _ConfirmPasswordInput(),
              SizedBox(height: 18.h),
              _SignUpButton(),
              SizedBox(height: 18.h),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already hava an account',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(AppRoutesName.LOGIN_SCREEN),
                      child: Text('login'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
              width: 50.w,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(8.r))),
              margin: EdgeInsets.only(right: 15.w),
              child: const Icon(
                Icons.password_rounded,
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: !context.watch<ShowPasswordCubit>().state,
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
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.blue,
            ),
            errorText: state.password.invalid ? 'invalid password' : null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.all(8.r),
            prefixIcon: Container(
              width: 50.w,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(8.r))),
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          onChanged: (password) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(password),
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
              width: 50.w,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(8.r))),
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

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: Colors.orangeAccent,
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}
