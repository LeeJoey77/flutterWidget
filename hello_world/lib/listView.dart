import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Scaffold Demo'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index){
          return new Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 44,
            alignment: Alignment.center,
            child: Text('data: $index'),
          );
        },
        itemCount: 100,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}