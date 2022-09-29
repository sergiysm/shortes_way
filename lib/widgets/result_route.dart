import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/data_routes.dart';
import 'package:a_star_algorithm/a_star_algorithm.dart';
import '../models/data_request.dart';

var resultA;

Future<List> listShortesWay() async {
  late Routes routes;
  routes = await getRouteList();
  List resultAList = [];

  var routeData = routes.data!;
  List listRoutes = [];
  List jsonList = [];
  for (int i = 0; i < routeData.length; i++) {
    listRoutes.add([]);
    var field = routeData[i].field;
    for (int s = 0; s < field!.length; s++) {
      listRoutes[i].add([]);
      for (int m = 0; m < field[s].length; m++) {
        listRoutes[i][s].add(field[s][m]);
      }
    }

    resultA = searchWay(
        list: listRoutes[i],
        start: routeData[i].start!,
        end: routeData[i].end!);

    resultAList.add(resultA);

    List<Steps> steps = [];
    for (var n in resultA) {
      steps.add(Steps(x: n.dx.toInt(), y: n.dy.toInt()));
    }
    var resultjson = Result(steps: steps, path: '');
    jsonList
        .add(RequestRoutes(id: routeData[i].id, result: resultjson).toJson());
  }
  return jsonList;
}

Iterable searchWay(
    {required List list,
    required Coordinates start,
    required Coordinates end}) {
  List ListResult = [];

  List<Offset> barriers = [];

  for (int i = 0; i < list.length; i++) {
    for (int s = 0; s < list.length; s++) {
      if (list[i][s] == 'X') {
        barriers.add(Offset(s.toDouble(), i.toDouble()));
      }
    }
  }

  return AStar(
    start: Offset(start.x!.toDouble(), start.y!.toDouble()),
    end: Offset(end.x!.toDouble(), end.y!.toDouble()),
    columns: list.length,
    rows: list.length,
    barriers: barriers,
    withDiagonal: true,
  ).findThePath();
}
