import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/app_bloc.dart';

class ScreenBloc {
  Map<String, dynamic> _data;

  ScreenBloc(BuildContext context) {
    _data = Provider.of<AppBloc>(context).data;
  }
}
