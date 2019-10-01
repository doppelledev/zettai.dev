import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/app_bloc.dart';
import 'package:test_app/screens/home_screen.dart';
import 'package:test_app/style.dart';

void main() => runApp(Portfolio());

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      title: 'Zettai Dev',
      home: Provider<AppBloc>(
        builder: (_) => AppBloc(),
        dispose: (_, bloc) => bloc.dispose(),
        child: HomeScreen(),
      ),
    );
  }
}
