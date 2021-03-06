import 'package:flutter/material.dart';
import 'container.dart';//Container
import 'stateful.dart';//StatefulWidget
import 'scaffold.dart';//Scaffold
import 'navigator.dart';
import 'rowColumnStack.dart';
import 'asynchronous.dart';
import 'futureAndStream.dart';
import 'http.dart';
import 'textfield.dart';




import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(new MyApp());

//基础:
//1. Widget
//Flutter 中一切皆 Widget,  Widget是不可变的, 而且不能被直接更新,你需要去操纵 widget 的 state
//StatelessWidget 和 StatefulWidget区别:
//StatefulWidget 拥有一个 State 对象来存储它的状态，并在 widget 树重建时携带着它，因此状态不会丢失

//2. 基础 Widget
//生命周期
//MaterialApp, Scaffold, Container等基础 Widget及使用

//3. ViewController, Navigation, Tabbar, 网络请求
//Widget 的 Key

//[Expanded] 和 [Flexible]
//填充方式


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      // home: ContainerWidget(),
      // home: ScaffoldWidget(),
      // home: NavigatorSample(),
      // home: RowAndColumnSample(),
      // home: CustomWidget(),
      // home: ParentCWidget(),
      home: AsynchronouseSample(),
      // home: FutureSample(),
      // home: HttpSample(),
      // home: TextFieldSample(),
      /*
      home: new ShoppingList(
        products: <Product>[
          new Product(name: 'eggs'),
          new Product(name: 'flour'),
          new Product(name: 'chocolate chips'),
        ],
      ),
      */
    );
  }
}

//Navigator, Future await async, constructor, generic type


