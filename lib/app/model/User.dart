import 'package:dailyplanner/other/Codable.dart';

class User extends Codable {
  User({data}) : super(data ?? Map<String, dynamic>());

  String get name => get("name");
  String get phone => get("phone");
}