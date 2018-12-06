import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async'; //异步

/// Asynchronous Programming: Streams
/// 
/// Streams 提供了一个异步的数据序列.
/// 这个数据序列包含用户产生的事件以及从文件中读取的数据
/// 处理 Stream 可以使用 await for 或 Stream API 的 listen()
/// Stream 提供了一个处理 error 的方法
/// 有两种 Streams: single subscription or broadcast.
/// 
/// Dart 中的异步编程以 Future 和 Stream 类为特征.
/// Future 代表不能立即完成的运算.常规的函数返回结果, 异步函数返回 Future.
/// Stream 是一个异步事件的序列.Stream 像异步的 iterable, 不需要你主动去获取下一个事件,
/// 当事件准备好时 Stream 会告诉你.
/// 
/// Receiving stream events
/// Stream 有许多创建方式, 它们都可以以一种方式使用: 异步循环遍历 stream 的 events 就像
/// for loop 遍历一样(通常叫 await for).
/// 见例1
/// 例1 的代码简单的接收了 integer events stream 的每个 stream,并且把它们相加返回.
/// 当 loop 体结束时, 函数停止直到下一个 event 到来或 stream 结束.
/// await for 要和 async 搭配使用.
/// 
/// Error events
/// 当没有更多 events 时 Streams 结束, 接收 events 的代码会被告知 Streams 结束, 
/// 新 event 到来时类似.使用 await for 读取 events 时, stream 结束, loop 停止
/// 
/// 在一些场景中, stream 结束前会发生 error, 例如请求数据时网络失败,或代码创建的 event
/// 有 bug.
/// 
/// Stream 可以像传递 data events 一样传递 error events.大多数 streams 在遇到第一个 
/// error 时停止, 但是也可以让 streams 传递多个 error, 或者让 streams 在遇到一个 error 之后
/// 传递 data.这里只讨论 最多传递一个 error 的 streams.
/// 
/// 当使用 await for 读取 stream 时, error 被 loop 语句 thrown. 同时, loop 也会停止.
/// 可以使用 try-catch 语句捕获 error.


class AsynchronousStreamsSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Scaffold Demo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.face),
            tooltip: 'iconbutton',
            onPressed: () async{
              // var stream = countStream(10);
              // var sum = await sumStream(stream);
              // print(sum);

              var streamError = countStreamError(10);
              var sumError = await sumStreamError(streamError);
              print(sumError);
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
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    sum += value;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i;
  }
}

/// 例2
Future<int> sumStreamError(Stream<int> stream) async {
  var sum = 0;
  try {
    await for (var value in stream) {
      sum += value;
    }
  } catch (e) {
    return -1;
  }
  return sum;
}

Stream<int> countStreamError(int to) async* {
  for (int i = 1; i <= to; i++) {
    if (i == 4) {
      throw new Exception('intentional exception');
    } else {
      yield i;
    }
  }
}