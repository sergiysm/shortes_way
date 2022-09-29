import 'package:flutter/material.dart';
import '../widgets/result_route.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result list screen')),
      /*body: ListView.builder(
        itemCount: routeList.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(routeList[index]);
        },
      ),*/
    );
  }
}
