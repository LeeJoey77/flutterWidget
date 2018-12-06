import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async'; //异步

/// Future 代表一个延迟计算的对象
/// Future 代表未来某一时刻可能得到的值或错误.
/// [Future] 的 Receivers 可以注册一个回调来处理值或错误, 一旦它们返回.
///
/// Future<int> future = getFuture();
///     future.then((value) => handleValue(value))
///           .catchError((error) => handleError(error));
///
/// future.then 的两个回调的结果是一个新的 Future
///
/// Future<int> successor = future.then((int value) {
///     // Invoked when the future is completed with a value.
///     return 42;  // The successor is completed with the value 42.
///   },
///   onError: (e) {
///     // Invoked when the future is completed with an error.
///     if (canHandle(e)) {
///       return 499;  // The successor is completed with the value 499.
///     } else {
///       throw e;  // The successor is completed with the error e.
///     }
///   });
///
/// 如果 Future 的回调 successor 是一个 error, 会进一步将 error message 传递给全局的
/// error-handler.这样可以确保没有 error 会被 silently dropped.
/// 然而, 这也意味着 error handler 应该被提前设置, 以便出现 error 时可以尽快使用
/// 下边的例子说明了这个潜在的 bug:
/// var future = getFuture();
/// new Timer(new Duration(milliseconds: 5), () {
///   // The error-handler is not attached until 5 ms after the future has
///   // been received. If the future fails before that, the error is
///   // forwarded to the global error-handler, even though there is code
///   // (just below) to eventually handle the error.
///   future.then((value) { useValue(value); },
///               onError: (e) { handleError(e); });
/// });
///
/// 当注册回调时, 单独注册两个回调会更 readable
/// 使用串行而不是并行 handler 会使代码更易读
/// 也使异步代码类似于同步代码:
/// 同步代码
/// try {
///   int value = foo();
///   return bar(value);
/// } catch (e) {
///   return 499;
/// }
///
/// 基于 future 的等价的异步代码:
///
/// Future<int> future = new Future(foo);  // Result of foo() as a future.
/// future.then((int value) => bar(value))
///       .catchError((e) => 499);
///
/// Future 可以注册多对 callback-pair. 每个 successor 被独立对待和处理.
///
/// Future 也可能没有 complete, 这种情况下没有回调被调用

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
              _getData();
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
  var uri =
      Uri.http('117.139.13.231:26840', 'rest/project/app/queryProjectList');
  Future<HttpClientRequest> future = httpClient.getUrl(uri);
  Timer(Duration(milliseconds: 5), () {
    Future successor = future.then((onValue) {
      print(onValue.uri);
      return onValue;
    }, onError: (error) {
      print(error);
      return error;
    });
    print(successor);
  });

  // Future<HttpClientRequest> successor = future.then((onValue) {
  //   print(onValue.uri);
  // }, onError: (error) {
  //   print(error);
  // });
}