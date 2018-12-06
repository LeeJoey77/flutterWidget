import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async'; //异步

/// Dart 是单线程执行.
/// Future 对象代表稍后异步执行的结果.
/// 要想推迟代码执行直到 Future 完成, 可以在异步函数中使用 await, 或者使用 then().
/// 要想捕获 error, 可以在异步函数中使用 try-catch 表达式, 或者使用 catchError().
/// 要想同步执行, 可以创建一个 isolate.
///
/// Future
/// Future<T> 代表一个会返回类型 T 的异步操作, 如果返回结果不是一个可用的值, Future 的类型
/// 是 Future<void>. 当返回值为 Future 的函数被调用时:
/// (1). 函数把要完成的任务排成队列, 并且返回一个 uncompleted Future 对象.
/// (2). 之后, 当操作完成,Future complete 附带一个值或 error
///
/// 使用 Future, 有两种选择:
/// (1). 使用 async 和 await
/// (2). 使用 Future API
///
/// Async and await
/// Async 和 await 是 Dart 语言异步支持的一部分. 它们可以让你写的异步代码像同步代码一样, 而不用
/// 使用 Future API.
///
/// 一个 async 函数会立即执行(synchronously).当第一次遇到下列情形之一, 函数 suspend execution
/// 并且返回一个 uncompleted future:
/// (1).函数的第一个 await 表达式(在函数得到 uncompleted future 之后)
/// (2).任意 return 语句
/// (3).函数体的结束
///
/// Handling errors
/// 如果一个返回值为 Future 的函数以 error 结束, 可以使用 try-catch 捕获并处理 error: 例1
/// try-catch 语句使用同步代码实现了异步代码的效果.
///
/// Sequential processing
/// 例2
/// 
/// The Future API
/// 在Dart 1.9 async 和 await 被添加到 Dart 之前, 只有 Future API.在比较旧的代码中或需要更多
/// functionality 而不是 async-await offers 的代码中, 仍然可以看到 Future API.
/// 使用 Future API 写异步代码, 需要使用 then() 方法注册回调, 当 Future 完成时回调触发.
/// 
/// 


class AsynchronouseSample extends StatelessWidget {
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
              printActions();
              // expensiveOperations();
            },
          )
        ],
      ),
      // body: _scaffoldBody(),
      backgroundColor: Color.fromRGBO(255, 100, 10, 1),
    );
  }
}

/// 例1
void printActions() {
  printDailyNewsDigest();
  printBaseballScore();
  printWeatherForecast();
  printWinningLotteryNumbers();
}

Future<void> printDailyNewsDigest() async {
  /*
  try {
    var newsDigest = await gatherNewsReports();
    print(newsDigest);
  } catch (e) {
    // handle error...
  }
  */

  Future future = gatherNewsReports();
  return future.then(print);

}

const news = 'gathered news';
const oneSecond = Duration(seconds: 1);

Future<String> gatherNewsReports() {
  return Future.delayed(oneSecond, () => news);
}

void printWinningLotteryNumbers() {
  print('winning lotto numbers:');
}

void printWeatherForecast() {
  print("tomorrow's forecast:");
}

void printBaseballScore() {
  print('Baseball scrore:');
}

/// 例2
void expensiveOperations() async {
  await expensiveA();
  await expensiveB();
  doSomethingWith(await expensiveC());
}

Future<String> expensiveA() {
  return Future.delayed(Duration(seconds: 1), () {
    print('A');
    return 'A';
  });
}

Future<String> expensiveB() {
  return Future.delayed(Duration(seconds: 1), () {
    print('B');
    return 'B';
  });
}

void doSomethingWith(String opera) {
  
}

Future<String> expensiveC() {
  return Future.delayed(Duration(seconds: 1), () {
    print('C');
    return 'C';
  });
}
