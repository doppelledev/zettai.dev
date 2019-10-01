import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/project.dart';
import 'package:test_app/screens/details_screen.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({this.project});

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with TickerProviderStateMixin {
  Project project;
  CardState state = CardState.none;
  AnimationController _controller;
  AnimationController _colorController;
  Animation _colorAnimation1;
  Animation _colorAnimation2;

  @override
  void initState() {
    super.initState();
    project = widget.project;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _colorController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _colorAnimation1 = ColorTween(begin: Colors.transparent, end: Colors.black)
        .animate(_colorController);
    _colorAnimation2 = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_colorController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _animate(CardState mState) {
    if (state != CardState.none && state != mState) return;
    if (state == CardState.none) {
      _controller.forward();
      state = mState;
    } else {
      _controller.reverse();
      state = CardState.none;
    }
  }

  void _animateColor(bool hovered) {
    hovered ? _colorController.forward() : _colorController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _animate(CardState.clicked);
        },
        onHover: (_) {
          _animate(CardState.hovered);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/projects/${project.id}/logo.png',
              fit: BoxFit.cover,
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => Opacity(
                opacity: _controller.value,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Transform(
                        transform: Matrix4.translationValues(
                          0,
                          -80 + 80 * _controller.value,
                          0,
                        ),
                        child: AutoSizeText(
                          project.title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 100.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                          0,
                          80 - 80 * _controller.value,
                          0,
                        ),
                        child: AnimatedBuilder(
                          animation: _colorController,
                          builder: (context, _) => Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.black26,
                              highlightColor: Colors.black26,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (context, _, __) =>
                                          DetailsScreen(project: project)),
                                );
                              },
                              onHover: (hovered) {
                                _animateColor(hovered);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                    color: _colorAnimation1.value,
                                    border: Border.all(color: Colors.black)),
                                child: Text(
                                  'Show more',
                                  style: TextStyle(
                                    color: _colorAnimation2.value,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CardState { none, clicked, hovered }
