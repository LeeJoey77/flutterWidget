import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

/*
官方使用的是用dart io中的HttpClient发起的请求，但HttpClient本身功能较弱，
很多常用功能都不支持。我们建议您使用dio 来发起网络请求，
它是一个强大易用的dart http请求库，支持Restful API、FormData、
拦截器、请求取消、Cookie管理、文件上传/下载……详情请查看github dio .
*/


class HttpSample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  _getData();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Scaffold Demo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.face),
            tooltip: 'iconbutton',
            onPressed: () {
            },
          )
        ],
      ),
      // body: _scaffoldBody(),
      backgroundColor: Color.fromRGBO(255, 100, 10, 1),
    );
  }
}

/*
一. 发起HTTP请求
http支持位于dart:io，所以要创建一个HTTP client， 我们需要添加一个导入：
import 'dart:io';

var httpClient = new HttpClient();
该 client 支持常用的HTTP操作, such as GET, POST, PUT, DELETE

二.处理异步
注意，HTTP API 在返回值中使用了Dart Futures。 我们建议使用async/await语法来调用API。

网络调用通常遵循如下步骤：
1. 创建 client.
2. 构造 Uri.
3. 发起请求, 等待请求，同时您也可以配置请求headers、 body。
4. 关闭请求, 等待响应.
5. 解码响应的内容.

get() async {
  var httpClient = new HttpClient();
  var uri = new Uri.http(
      'example.com', '/path1/path2', {'param1': '42', 'param2': 'foo'});
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  var responseBody = await response.transform(UTF8.decoder).join();
}

三. 解码和编码JSON
使用dart:convert库可以简单解码和编码JSON。 有关其他的JSON文档，请参阅JSON和序列化。

解码简单的JSON字符串并将响应解析为Map：

Map data = JSON.decode(responseBody);
// Assume the response body is something like: ['foo', { 'bar': 499 }]
int barValue = data[1]['bar']; // barValue is set to 499
要对简单的JSON进行编码，请将简单值（字符串，布尔值或数字字面量）或包含简单值的Map，list等传给encode方法：

String encodedString = JSON.encode([1, 2, { 'a': null }]);
*/
void _getData() async {
  /*
  var httpClient = HttpClient();
  var uri = Uri.http('http://117.139.13.231:26840', '/rest/auth/logout');
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  var responseBody = await response.transform(utf8.decoder).join();
  Map data = json.decode(responseBody);
  print(data);
  */

  /* */
  Dio dio = new Dio();
  Response<Map> response=await dio.get("http://117.139.13.231:26840/rest/auth/logout");
  print(response.data);
  
}