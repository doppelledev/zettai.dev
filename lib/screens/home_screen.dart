import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/app_bloc.dart';
import 'package:test_app/components/main_menu.dart';
import 'package:test_app/screens/about_screen.dart';
import 'package:test_app/screens/projects_screen.dart';
import 'package:test_app/screens/services_screen.dart';
import 'package:test_app/style.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AppBloc _bloc;
  TabController _controller;
  AnimationController _animationController;
  Animation _animation;
  bool _ready = false;
  bool _waited = false;
  bool _snacked = false;

  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.addListener(() {
      setState(() {});
    });
    _animation =
        CurvedAnimation(curve: Curves.easeInExpo, parent: _animationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<AppBloc>(context);
    _bloc.outReady.listen((ready) {
      if (ready) {
        _ready = true;
        if (_waited) _fade();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _wait() async {
    await Future.delayed(Duration(seconds: 2));
    _waited = true;
    if (_ready) _fade();
  }

  void _fade() async {
    await _animationController.forward();
  }

  void _snack() {
    if (!_snacked) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Row(
          children: <Widget>[
            Text(
              'Flutter for web hasn\'t even reached alpha yet. You may encoutner some bugs'
              ', especially if you\'re using anything other than chrome',
            ),
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
        duration: Duration(seconds: 10),
      ));
      _snacked = true;
    }
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      _wait();
      _snack();
    });
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          body: TabBarView(
            controller: _controller,
            children: [
              AboutScreen(_bloc.about),
              ProjectsScreen(_bloc.projects),
              ServicesScreen(),
            ],
          ),
        ),
        SizedBox(
          height: AppBar().preferredSize.height,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.white70,
              elevation: 0.0,
              title: MainMenu(_controller),
            ),
          ),
        ),
        Visibility(
          visible: _animationController.value != 1,
          child: Opacity(
            opacity: 1 - _animation.value,
            child: Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      'Zettai',
                      style: TextStyle(
                        fontSize: 100,
                        color: myGrey,
                      ),
                    ),
                    Text(
                      'I get stuff done...',
                      style: TextStyle(
                        color: myGrey,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
