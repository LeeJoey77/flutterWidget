import 'package:flutter/material.dart';
import 'dart:async'; //异步

/// Navigator 定义:
/// 一个使用 Stack discipline 来管理子 Widget 的 Widget
///
/// ## Using the Navigator
///
/// 在 Flutter 中 full-screen elements 被称为 [route],由 [Navigator] 以栈的方式管理.
/// 基本方法 [Navigator.push], [Navigator.pop]
///
/// ### Displaying a full-screen route
///
/// 虽然可以自己创建 Navigator, 但是最常见的是使用 [WidgetsApp] 或 [MaterialApp]
/// 创建的 [Navigator], 使用 [Navigator.of] 获取.
///
/// [MaterialApp] 的 [home]: 相当于 rootViewController
/// [MaterialApp] 是创建 APP 的最简单的方法, [MaterialApp] 的 [home] 是
/// [Navigator] 栈中的第一个界面, 即 App 启动后看到的界面
///
/// PUSH 方法:
/// 要 push 到一个新的 route, 可以用 builder function 创建一个 [MaterialPageRoute] 的实例
/// 如下例:
///
/// ```dart
/// Navigator.push(context, MaterialPageRoute<void>(
///   builder: (BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: Text('My Page')),
///       body: Center(
///         child: FlatButton(
///           child: Text('POP'),
///           onPressed: () {
///             Navigator.pop(context);
///           },
///         ),
///       ),
///     );
///   },
/// ));
/// ```
///
/// 使用 builder function 定义 route widget, 而不是用 child widget, 是因为它要在不同的
/// context 中被 build 和 rebuild
///
/// POP 方法:
/// route 的 pop 方法如下:
/// ```dart
/// Navigator.pop(context);
/// ```
/// 对于 Scaffold, 通常不需要提供一个 widget 来 pop 界面, 因为 Scaffold 在 AppBar 上
/// 自动添加了一个返回按钮
///
/// ### Using named navigator routes
///
/// APP 通常有很多 routes, 找到它们最简单的方法是根据名字. 按照惯例, Route 名使用类似
/// 路径的结构('/a/b/c'), APP 的 home page route 默认为 '/'
///
/// [MaterialApp] 可以由 [Map<String, WidgetBuilder>] 创建, Map 将 route name 和
/// 创建它的 builder function 相匹配, [MaterialApp] 用这个 map 为它的 navigator's
/// [onGenerateRoute] 的会回调创造一个值
///
/// ```dart
/// void main() {
///   runApp(MaterialApp(
///     home: MyAppHome(), // becomes the route named '/'
///     routes: <String, WidgetBuilder> {
///       '/a': (BuildContext context) => MyPage(title: 'page A'),
///       '/b': (BuildContext context) => MyPage(title: 'page B'),
///       '/c': (BuildContext context) => MyPage(title: 'page C'),
///     },
///   ));
/// }
/// ```
///
/// ```dart
/// Navigator.pushNamed(context, '/b');
/// ```
/// ### Routes can return a value
///
/// route 可以通过 pop 方法的 [result parameter] 返回一个返回值
///
/// push route 的方法返回一个 [Future](Future 代表一个潜在的值或 error) 值,
/// 当 route 被 pop 时, Future 被 resolve, Future 的值就是 [pop] 方法的 [result parameter]
/// 例如: 当想让用户点击一个 OK 按钮确认一个操作时, 我们可以 `await` [Navigator.push] 的结果
///
/// ```dart
/// bool value = await Navigator.push(context, MaterialPageRoute<bool>(
///   builder: (BuildContext context) {
///     return Center(
///       child: GestureDetector(
///         child: Text('OK'),
///         onTap: () { Navigator.pop(context, true); }
///       ),
///     );
///   }
/// ));
/// ```
/// 当用户点击 OK 按钮, value 为 true, 如果用户返回, 该值为 null
///
/// 当 route 被用来返回一个值的时候, route 的 type 必须和 pop 的 result 类型匹配
/// 所以上例中使用 `MaterialPageRoute<bool>` 而不是 `MaterialPageRoute<void>` 或
/// `MaterialPageRoute`.(不指定类型也是可以的)
///
/// ### Popup routes
///
/// route 不需要遮挡整个屏幕, [PopupRoute] 的 [ModalRoute.barrierColor] 可以让屏幕半透明.
/// Popup routes are "modal", 因为它们可以阻挡下方 widget 的输入
///
/// 有函数可以创建并展示 popup routes.例如: [showDialog], [showMenu], [showModalBottomSheet],
/// 这些函数返回它们 pushed route's Future, 函数的调用可以 await the returned value, 等到 pop
/// 的时候 take an action
///
/// 有些 widget 也可创建 popup routes, 例如: [PopupMenuButton] 和 [DropdownButton],
/// 这些 widget 创建了 PopupRoute 的子类, 并使用 [Navigator]'s push 和 pop 方法 show 或 dismiss route
///
/// ### Custom routes
///
/// 可以创建 widget library route classes(比如: [PopupRoute], [ModalRoute], [PageRoute])
/// 的子类来控制 route 的 animated transition, modal barrier 的color and behavior, 以及其它方面
///
/// [PageRouteBuilder] 类可以创建一个带 callback 的 custom route
/// 下边的例子中, route 出现和消失时, child 会 rotate 和 fade, 而且 route 没有遮挡这个屏幕, 因为设置
/// `opaque: false`, 就像 popup route
/// ```dart
/// Navigator.push(context, PageRouteBuilder(
///   opaque: false,
///   pageBuilder: (BuildContext context, _, __) {
///     return Center(child: Text('My PageRoute'));
///   },
///   transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
///     return FadeTransition(
///       opacity: animation,
///       child: RotationTransition(
///         turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
///         child: child,
///       ),
///     );
///   }
/// ));
/// ```
/// page route 分两部分创建, page 和 transitions, page 变成了 child 的 descendant
/// 传递给 `buildTransitions` 方法.一般来说 page 值创建一次, 因为它不依赖于 animation parameters,
/// transition 在过渡中的每一帧都要创建
///
/// ### Nesting Navigators
/// 一个 APP 可以使用不止一个 Navigator
///
/// #### Real World Example
/// 可以用 tab 管理几个平行的 Navigator, tab 又嵌套于一个 root [Navigator]. [WidgetApp] 和
/// [CupertinoTabView] 中都有这种结构, 可以直接使用
///
/// 下例是一个注册功能:
///
/// ```dart
/// class MyApp extends StatelessWidget {
///  @override
///  Widget build(BuildContext context) {
///    return MaterialApp(
///      // ...some parameters omitted...
///      // MaterialApp contains our top-level Navigator
///      initialRoute: '/',
///      routes: {
///        '/': (BuildContext context) => HomePage(),
///        '/signup': (BuildContext context) => SignUpPage(),
///      },
///    );
///  }
/// }
///
/// class SignUpPage extends StatelessWidget {
///  @override
///  Widget build(BuildContext context) {
///    // SignUpPage builds its own Navigator which ends up being a nested
///    // Navigator in our app.
///    return Navigator(
///      initialRoute: 'signup/personal_info',
///      onGenerateRoute: (RouteSettings settings) {
///        WidgetBuilder builder;
///        switch (settings.name) {
///          case 'signup/personal_info':
///            // Assume CollectPersonalInfoPage collects personal info and then
///            // navigates to 'signup/choose_credentials'.
///            builder = (BuildContext _) => CollectPersonalInfoPage();
///            break;
///          case 'signup/choose_credentials':
///            // Assume ChooseCredentialsPage collects new credentials and then
///            // invokes 'onSignupComplete()'.
///            builder = (BuildContext _) => ChooseCredentialsPage(
///              onSignupComplete: () {
///                // Referencing Navigator.of(context) from here refers to the
///                // top level Navigator because SignUpPage is above the
///                // nested Navigator that it created. Therefore, this pop()
///                // will pop the entire "sign up" journey and return to the
///                // "/" route, AKA HomePage.
///                Navigator.of(context).pop();
///              },
///            );
///            break;
///          default:
///            throw Exception('Invalid route: ${settings.name}');
///        }
///        return MaterialPageRoute(builder: builder, settings: settings);
///      },
///    );
///  }
/// }
/// ```
///
/// [Navigator.of] 是对 [BuildContext] 中最近的祖先 Navigator 进行操作, 要确保给
/// 想要操作的 Navigator 提供一个 [BuildContext], 尤其是在创建 Navigator 的大的 [build]
/// 方法中, [Builder] widget 可以用来获取 [BuildContext] 在 widget subtree 的任意位置

class NavigatorSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Navigator Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '首页'),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => MyPage(title: 'Page A'),
        '/b': (BuildContext context) => MyPage(title: 'Page B'),
        '/c': (BuildContext context) => MyPage(title: 'Page c'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _openNewPage() {
    setState(() {
      /*
      //根据 name 导航
      Navigator.pushNamed(context, '/b');
      */

      /*
      Future<String> value = Navigator.of(context).push(new MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('新的页面')
            ),
            body: new Center(
              child: new Text(
                '点击浮动按钮返回首页',
              ),
            ),
            floatingActionButton: new FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop('string');
              },
              child: new Icon(Icons.replay),
            ),
          );
           
        },
      ));
    
      var completer = new Completer<String>.sync();
      var onValue = (String value) {
        if (!completer.isCompleted) {
          print(value);
          completer.complete(value);
        } 
      };
      var onError = (error, stack) {
        if (!completer.isCompleted) {
          completer.completeError(error, stack);
          print(error);
        } 
      };
      value.then(onValue, onError: onError);
      */
      
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return Center(child: Text('My PageRoute'));
              },
              transitionsBuilder:
                  (___, Animation<double> animation, ____, Widget child) {
                return FadeTransition(
                  opacity: animation,
                  child: RotationTransition(
                    turns:
                        Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                    child: child,
                  ),
                );
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Text(
          '点击浮动按钮打开新页面',
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _openNewPage,
        child: new Icon(Icons.open_in_new),
      ),
    );
  }
}

// 根据 name 导航
class MyPage extends StatefulWidget {
  MyPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(child: Text('routed by name')),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.today),
      ),
    );
  }
}
