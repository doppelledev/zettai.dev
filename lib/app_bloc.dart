import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;
import 'package:rxdart/rxdart.dart';
import 'package:test_app/models/project.dart';

class AppBloc {
  final List<Project> projects = List<Project>();
  Map<String, dynamic> data;
  String about;

  BehaviorSubject<bool> _readySubject = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get outReady => _readySubject.stream;
  Sink<bool> get _inReady => _readySubject.sink;

  AppBloc() {
    init();
  }

  void init() async {
    final source = await rootBundle.loadString("assets/data.json");
    data = convert.jsonDecode(source);
    for (var p in data['projects']) projects.add(Project.fromJSON(p));
    about = data['about'];
    _inReady.add(true);
  }

  void dispose() {
    _readySubject.close();
  }
}
