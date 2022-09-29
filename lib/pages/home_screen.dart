import 'package:flutter/material.dart';
import '../models/const.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String textValidUrlAPI = 'Set valid API base URL in order to continue';
  bool _validURL = false;
  String _uri = '';

  @override
  void initState() {
    super.initState();
    if (uri != '') {
      showTextValidURL(uri);
    }
  }

  void showTextValidURL(value) {
    _validURL = Uri.parse(value).isAbsolute;
    _uri = value;
    if (_validURL == true) {
      textValidUrlAPI = 'Valid API URL';
    } else if (value == '') {
      textValidUrlAPI = 'Set valid API base URL in order to continue';
    } else {
      textValidUrlAPI = 'It is not URL';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textValidUrlAPI,
                ),
                TextFormField(
                  initialValue: uri,
                  onFieldSubmitted: (value) {
                    showTextValidURL(value);
                  },
                  decoration: const InputDecoration(
                      icon: Icon(Icons.swap_horiz), helperText: 'URL'),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 10, right: 10),
                    ),
                    onPressed: _validURL == false
                        ? null
                        : () {
                            var box = Hive.box('box');
                            box.put('uriApi', _uri);
                            uri = _uri;
                            Navigator.pushNamed(context, '/process_screen');
                          },
                    child: const Text('Start counting process'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
