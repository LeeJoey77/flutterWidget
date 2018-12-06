import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async'; //异步

/// Asynchronous Programming: Futures
/// 
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
/// 如果一个返回值为 Future 的函数以 error 结束, 可以使用 try-catch 捕获并处理 error:
/// 见例1
/// try-catch 语句使用同步代码实现了异步代码的效果.
///
/// Sequential processing
/// 见例2
/// 
/// The Future API
/// 在Dart 1.9 async 和 await 被添加到 Dart 之前, 只有 Future API.在比较旧的代码中或需要更多
/// functionality 而不是 async-await offers 的代码中, 仍然可以看到 Future API.
/// 使用 Future API 写异步代码, 需要使用 then() 方法注册回调, 当 Future 完成时回调触发.
/// 见例3
/// 即使 Future 是 Future<void> 类型也需要提供给 then() 的回调提供参数.
/// 按照惯例, 未使用的参数使用下划线.
/// 
/// Handling errors
/// 根据 Future API, 可以使用 catchError() 捕获 error:
/// 例4
/// 发生错误的执行顺序:
/// (1). gatherNewsReports() 返回一个错误的 Future 值
/// (2). then() 的返回值 Future 返回一个 error, print 方法不执行
/// (3). catchError() 回调处理错误, catchError() 的返回值 future complete, 
/// error 不会传播.
/// 
/// Calling multiple functions that return futures
/// 对于 expensiveA(), expensiveB(), expensiveC() 三个返回 Future 的函数, 
/// 可以顺序调用, 也可以一次同时调用.
/// 
/// Chaining function calls using then()
/// 返回 future 的函数需要按序执行时, 可以用 then() 将它们串联起来:
/// 例5
/// 也可以使用嵌套,但是嵌套不易读
/// 
/// Waiting on multiple futures to complete using Future.wait()
/// 如果函数的执行顺序不重要, 可以使用 Future.await().
/// 当给 Future.wait() 传递一串 futures 值时, 它会立即返回一个 Future.这个 Future
/// 直到所有 futures 都 complete 才会 complete, 并且带有所有 futures 值的列表.
/// 例6
/// 如果任何一个函数 error, Future.wait() complete with an error.
/// 


class AsynchronousFuturesSample extends StatelessWidget {
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
  // printDailyNewsDigestAsyncAndAwait();
  printDailyNewsDigestFutureAPI();
  printBaseballScore();
  printWeatherForecast();
  printWinningLotteryNumbers();
}

//async, await
Future<void> printDailyNewsDigestAsyncAndAwait() async {
  try {
    var newsDigest = await gatherNewsReports();
    print(newsDigest);
  } catch (e) {
    // handle error...
  }
}

//例3
//Future API
Future<void> printDailyNewsDigestFutureAPI() {
  final future = gatherNewsReports();
  return future.then(print);

  //或
  // return future.then((newsDigest) {
  //   print(newsDigest);
  // });
  // future.then(print) 等价于 future.then((newsDigest) => print(newsDigest))
  // You don't *have* to return the future here.
  // But if you don't, callers can't await it.

  /// 即使 Future 是 Future<void> 类型也需要提供给 then() 的回调提供参数.
  /// 按照惯例, 未使用的参数使用下划线.
  // return future.then((_) {
  //   print('abcd');
  // });
}

/// 例4
Future<void> printDailyNewsDigest() {
  final future = gatherNewsReports();
  return future.then((value) {
    print(value);
  })
  .catchError((error) {

  });
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

/// 例5
void expensiveOperationChainFunction() {
 expensiveA()
    .then((aValue) => expensiveB())
    .then((bValue) => expensiveC())
    .then((cValue) => doSomethingWith(cValue));
//// 也可以使用嵌套,但是嵌套不易读
}

/// 例6
void expensiveOperationList() {
  Future.wait([expensiveA(), expensiveB(), expensiveC()])
    .then((List responses) {
      // chooseBestResponse(responses, moreInfo)
    })
    .catchError((_) {

    });
}