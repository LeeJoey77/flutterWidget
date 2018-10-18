import 'package:flutter/material.dart';
/*
1. 在 Flutter 中，widgets 是不可变的，而且不能被直接更新。你需要去操纵 widget 的 state。
2. StatefulWidget 和 StatelessWidget 区别:
StatefulWidget 拥有一个 State 对象来存储它的状态数据，并在 widget 树重建时携带着它，
因此状态不会丢失。如果你有疑惑，请记住以下规则：如果一个 widget 在它的 build 方法之外改变
(例如，在运行时由于用户的操作而改变), 它就是有状态的. 如果一个 widget 在一次 build 之后永远不变,
那它就是无状态的. 但是，即便一个 widget 是有状态的，包含它的父亲 widget 也可以是无状态的,
只要父 widget 本身不响应这些变化。
*/

//
class StatefullSample extends StatefulWidget {
   StatefullSample({Key key}) : super(key: key);
   @override
   _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<StatefullSample> {
  // Default placeholder text
  String textToShow = "I Like Flutter";
  void _updateText() {
    setState(() {
      // update the text
      textToShow = "Flutter is Awesome!";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(child: Text(textToShow)),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: Icon(Icons.update),
      ),
    );
  }
}