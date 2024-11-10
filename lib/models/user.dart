import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:amphi/utils/random_color.dart';

class User {
  String id;
  String name;
  String password;
  String token;
  String storagePath;
  Color color =  RandomColor.generate();

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.token,
    required this.storagePath
  });

  static User fromDirectory(Directory directory) {
    File file = File("${directory.path}/user_info.json");
    if(file.existsSync()) {
      try {
        Map<String, dynamic> map = jsonDecode(file.readAsStringSync());

        return User(id: map["id"] ?? "", name:map["name"] ?? "", password: "", token: map["token"] ?? "", storagePath: directory.path);
      } on Exception {
        return User(id: "", name: "", password: "", token: "", storagePath: directory.path);
      }
    }
    else {
      return User(id: "", name: "", password: "", token: "", storagePath: directory.path);
    }
  }

  @override
  String toString() {
    return '''
       id: $id,
      name: $name,
      password: $password,
      token: $token
    ''';
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "token": token
    };
  }
}