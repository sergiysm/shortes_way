import 'dart:convert';
import 'package:http/http.dart' as http;
import 'const.dart';

class Routes {
  bool? error;
  String? message;
  List<Data>? data;

  Routes({this.error, this.message, this.data});

  Routes.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  List<String>? field;
  Coordinates? start;
  Coordinates? end;

  Data({this.id, this.field, this.start, this.end});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = json['field'].cast<String>();
    start = json['start'] != null ? Coordinates.fromJson(json['start']) : null;
    end = json['end'] != null ? Coordinates.fromJson(json['end']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['field'] = this.field;
    if (this.start != null) {
      data['start'] = this.start!.toJson();
    }
    if (this.end != null) {
      data['end'] = this.end!.toJson();
    }
    return data;
  }
}

class Coordinates {
  int? x;
  int? y;

  Coordinates({this.x, this.y});

  Coordinates.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

Future<Routes> getRouteList() async {
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    return Routes.fromJson(json.decode(response.body));
  } else {
    throw Exception('');
  }
}
