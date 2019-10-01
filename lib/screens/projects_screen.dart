import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_app/components/project_card.dart';
import 'package:test_app/models/project.dart';

class ProjectsScreen extends StatelessWidget {
  final List<Project> projects;

  ProjectsScreen(this.projects);

  @override
  Widget build(BuildContext context) {
    int count;
    double width = MediaQuery.of(context).size.width;
    if (width > 900)
      count = 3;
    else if (width > 600)
      count = 2;
    else
      count = 1;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppBar().preferredSize.height + 16),
              Expanded(
                flex: 1,
                child: Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 8.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Expanded(
                flex: 9,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: count,
                  childAspectRatio: 4 / 3,
                  children: [for (var p in projects) ProjectCard(project: p)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
