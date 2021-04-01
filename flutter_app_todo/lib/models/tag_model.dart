import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Tag extends Equatable {
  final String id;
  final List<dynamic> color;
  final String tagName;

  Tag({
    @required this.id,
    @required this.color,
    @required this.tagName,
  });

  factory Tag.fromJson(Map<String, dynamic> data) {
    return Tag(
      id: data['id'],
      color: data['color'],
      tagName: data['tagName'],
    );
  }

  Map<String, dynamic> toJson(String id, List<int> color, String tagNamed) {
    Map<String, dynamic> a = {
      'id': id,
      'color': color,
      'tagNamed': tagNamed,
    };
    return a;
  }
}
