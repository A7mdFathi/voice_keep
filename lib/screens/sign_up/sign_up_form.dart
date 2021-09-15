import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/show_password/show_password_cubit.dart';
import 'package:flutter_procrew/business_logic/signup_cubit/sign_up_cubit.dart';
import 'package:flutter_procrew/screens/login/login_form.dart';
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            SizedBox(height: 8.h),
            _PasswordInput(),
            SizedBox(height: 8.h),
            _ConfirmPasswordInput(),
            SizedBox(height: 8.h),
            _SignUpButton(),
          ],
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'confirm password',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
          ),
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
                key: const Key('signUpForm_continue_raisedButton'),
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
