import 'package:meta/meta.dart';

@immutable
class Project {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String video;
  final int screens;

  Project.fromJSON(Map<String, dynamic> json)
      : this.id = json['id'],
        this.title = json['title'],
        this.subtitle = json['subtitle'],
        this.description = json['description'],
        this.video = json['video'],
        this.screens = json['screens'];
}
