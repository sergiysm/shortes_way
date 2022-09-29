import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/const.dart';
import '../models/responses.dart';
import '../widgets/result_route.dart';

class ProcessScreen extends StatefulWidget {
  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

Future<List> processResultRoutes() async {
  var request = await listShortesWay();

  return request;
}

class _ProcessScreenState extends State<ProcessScreen> {
  //var urlAPI;
  late Future<List> request;

  @override
  void initState() {
    super.initState();
    //routes = getRouteList();
    request = processResultRoutes();
  }

  @override
  Widget build(BuildContext context) {
    //bool _working = true;
    String textvalue = '';
    var _request;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              textvalue,
              style: const TextStyle(fontSize: 25),
            ),
            /*const Text(
                '100%',
                style: TextStyle(fontSize: 25),
              ),*/
            SizedBox(
              width: 100,
              height: 100,
              child: const CircularProgressIndicator(),
            ),
            FutureBuilder<List>(
              future: request,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _request = snapshot.data;
                  return ElevatedButton(
                    onPressed: () {
                      //print(json.encode(snapshot.data));
                      /*var requestApi = http.post(Uri.parse(uri),
                          body: json.encode(_request));
                      var f = 5;*/
                      //getResponses(_request);
                      Navigator.pushNamed(context, '/result_list');
                    },
                    child: const Text('Send result to server'),
                  );
                }

                return const Text('process...');
              },
            ),
          ],
        ),
      ),
    );
  }
}

void getResponses(_request) async {
  final response = await http.post(Uri.parse(uri), body: json.encode(_request));
  if (response.statusCode == 200) {
    var responseRoute = ResponseRoute.fromJson(json.decode(response.body));
    5;
  } else {
    Exception('');
  }
}
