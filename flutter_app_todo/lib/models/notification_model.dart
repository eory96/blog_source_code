import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NotificationModel extends Equatable {
  final bool notification;

  NotificationModel({
    @required this.notification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> data) {
    return NotificationModel(
      notification: data['notification'],
    );
  }

  Map<String, dynamic> toJson(String id, List<int> color, String tagNamed) {
    Map<String, dynamic> a = {
      'notification': notification,
    };
    return a;
  }
}
