import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_app/models/project.dart';
import 'package:test_app/style.dart';
import 'package:universal_html/html.dart' as html;

class DetailsScreen extends StatelessWidget {
  final Project project;

  DetailsScreen({this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Material(
            color: Colors.black45,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 700.0,
              ),
              child: Stack(
                children: [
                  Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 250.0,
                            maxHeight: 400.0,
                          ),
                          child: ProjectHeader(project: project),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                project.title,
                                style: TextStyle(
                                  fontSize: 40.0,
                                ),
                              ),
                              Text(
                                project.subtitle,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: myGrey,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                width: double.infinity,
                                height: 1,
                                color: myGrey.withAlpha(0x55),
                              ),
                              Text(
                                project.description,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectHeader extends StatefulWidget {
  const ProjectHeader({
    @required this.project,
  });

  final Project project;

  @override
  _ProjectHeaderState createState() => _ProjectHeaderState();
}

class _ProjectHeaderState extends State<ProjectHeader>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  Project project;

  @override
  void initState() {
    super.initState();
    project = widget.project;
    _controller = TabController(length: project.screens + 1, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        TabBarView(
          controller: _controller,
          children: [
            Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/projects/${widget.project.id}/header.jpg',
                  width: width > 700 ? 700 : width,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Visibility(
                    visible: project.video != null,
                    child: Material(
                      color: Colors.black87,
                      shape: CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          html.window.open(project.video, 'randomname3');
                        },
                        hoverColor: Colors.white24,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            for (int i = 0; i < project.screens; i++)
              Image.asset(
                'assets/images/projects/${widget.project.id}/$i.jpg',
                width: width > 700 ? 700 : width,
                fit: BoxFit.cover,
              ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Visibility(
            visible: _controller.index > 0,
            child: Material(
              color: Colors.white54,
              shape: CircleBorder(),
              child: IconButton(
                onPressed: () {
                  _controller.animateTo(_controller.index - 1);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Visibility(
            visible: _controller.index + 1 < _controller.length,
            child: Material(
              color: Colors.white54,
              shape: CircleBorder(),
              child: IconButton(
                onPressed: () {
                  _controller.animateTo(_controller.index + 1);
                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
