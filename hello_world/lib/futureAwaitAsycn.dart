import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async'; //异步

class FutureSample extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Scaffold Demo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.face),
            tooltip: 'iconbutton',
            onPressed: () {
              print('onpressed');
            },
          )
        ],
      ),
      // body: _scaffoldBody(),
      backgroundColor: Color.fromRGBO(255, 100, 10, 1),
    );
  }
}

void _getData() async {
  var httpClient = HttpClient();
  var uri = Uri.http('117.139.13.231:26840', 'rest/project/app/queryProjectList');
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  var responseBody = await response.transform(utf8.decoder).join();
}