import 'package:flutter/material.dart';
import 'package:flutter_procrew/business_logic/auth/authentication_bloc.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => context.read<AuthenticationBloc>()
                ..add(AuthenticationLogout()),
              icon: Icon(Icons.logout))
        ],
        title: Text('Home'),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
