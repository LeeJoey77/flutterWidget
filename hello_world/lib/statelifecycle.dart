import 'package:flutter/material.dart';

/// Widget 中定义的变量是构造函数需要的属性, State 中定义的变量是 setState 时要改变的值
/// Widget 中调用 constructor 函数, 只调用一次. State 中 调用 build 函数 build Widget,
/// 当调用 setState() 改变 State 中的变量, build 函数重新运行
///
/// [State] 是 [StatefulWidget] 的 logic and internal state
/// 
/// State 是 information, 这个 information 中的 (1) 可以在 Widget 创建时被同步读取,
/// (2) 也许会在 Widget 的生命周期中改变.
/// widget implementer(即 StatefulWidget 的 build 方法) 的责任就是确保将 state 的改变,
/// 通过调用 [State.setState()] 方法及时通知 [State]
/// 
/// framework inflate [StatefulWidget] 时调用 [createState] 方法, 这意味着当 [StatefulWidget]
/// 被插入 Widget tree 的多个位置时, 会有多个 [State] 与之关联.
/// 同样地, 当一个 [StatefulWidget] 被从 Widget tree 上移除然后再次插入时, framework 会
/// 调用 [createState] 方法创建一个新的 [State], 简化 [State] 的生命周期.
/// 
/// [State] 对象的生命周期如下:
/// 
/// 1. framework 调用 [StatefulWidget.createState] 创建 [State] 对象.
/// 
/// 2. 新建的 [State] 对象 和一个 [BuildContext] 关联,这一关联是永久的:
/// [State] 永远不会改变它的  [BuildContext].然而,  [BuildContext] 可以沿着它的 subtree 移动.
/// 这时, [State] 对象被认为是 [mounted]
/// 
/// 3. framework 调用 [initState] 方法, 当 [initState] 方法被调用时, [State] 的子类应该 
/// override [initState] 来执行只执行一次的初始化, 初始化取决于 [BuildContext] 或 widget,
/// [BuildContext], widget 可以通过 [context], [widget] 属性获得.
/// 
/// 4. framework 调用 [didChangeDependencies]. [State] 的子类应该override
/// [didChangeDependencies] 来执行 [InheritedWidget]s 有关的初始化.如果
/// [BuildContext.inheritFromWidgetOfExactType] 被调用,  [didChangeDependencies] 方法
/// 在 inherited widgets 连续改变或 widget 在 tree 上移动时, 会被再次调用
/// 
/// 5. 到这一步, [State] 对象已经完全初始化, framework 可以多次调用 [build] 方法获取 subtree
/// 的用户界面的描述. [State] 对象可以调用 [setState] 方法请求 rebuild subtree, 调用 [setState]
/// 方法意味着内部的一些状态发生改变, 这些改变可能影响到 subtree.
/// 
/// 6. 在这个时间, parent widget might rebuild and request tree 中 this location 更新以
/// 展示有相同 [runtimeType] 和 [Widget.key] 的新 widget.此时, framework 将更新 [widget]
/// 属性, 指向一个新的 widget, 然后以之前的 widget 作为参数调用 [didUpdateWidget] 方法.
/// [State] 对象应该 override [didUpdateWidget], 来对与它们有关的 widget 的改变做出反应.
/// framework 总是在调用 [didUpdateWidget] 方法之后调用 [build] 方法, 这意味着在
/// [didUpdateWidget] 方法中调用 [setState] 是多余的
/// 
/// 7. 在开发中, 如果热重载发生, [reassemble] 方法被调用, 这提供了重新初始化在 [initState] 方法
/// 中准备的数据的机会.
/// 
/// 8. 如果包含 [State] 对象的 subtree 被从 tree 上移除.例如, parent 创建了一个有不同 
/// [runtimeType] 和 [Widget.key]的 widget.此时, framework 调用 [deactivate] 方法, 
/// 子类应该 override 这个方法清除这个对象和 tree 中其它 element 的联系.
/// 
/// 9. 到这一步, framework 可以将该 subtree reinsert到 tree 的另一部分, 此时, framework 会
/// 调用 [build] 方法给 [State] 对象一个机会来适应在 tree 中的新位置. 这些都会在 animation frame
/// 结束之前发生, subtree 是在 animation frame 中移除的.因此,  [State] 对象可以推迟释放大多
/// 数资源, 直到 framework 调用 [dispose] 方法.
/// 
/// 10. 如果在当前 animation frame 结束前, framework 没有 reinsert subtree, framework 将
/// 调用 [dispose] 方法, 调用 [dispose] 方法意味着 [State] 对象不会再被 build.子类应该 override
/// 这个方法释放这个对象所保留的所有资源.例如停止所有 active 动画.
/// 
/// 11. framework 调用 [dispose] 方法之后, [State] 对象被认为 unmounted, [mounted] 为 false.
/// 这个再调用 [setState] 方法就会报错. 这个生命周期的终点, 不能在 remount 一个已经被 disposed
/// [State] 对象
/// 
///

class FDInputWidget extends StatefulWidget {
  // Widget 中定义的变量是构造函数需要的属性
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  FDInputWidget({
    Key key,
    this.hintText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  _FDInputWidgetState createState() => _FDInputWidgetState();
}

class _FDInputWidgetState extends State<FDInputWidget> {
  //State 中定义的变量是 setState 时要改变的值
  final FocusNode _focusNode = FocusNode();
  var _hasDeleteBt = false; //是否创建清除按钮

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener); // 初始化一个listener
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(FDInputWidget oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose');
    _focusNode.removeListener(_focusNodeListener); // 页面消失时必须取消这个listener！！
    // WidgetsBinding.instance.removeObserver();
    super.dispose();
  }

  
  // @override
  // void didChangeAppLifecycleState(_FDInputWidgetState state) {
  //   switch (state) {
  //     case AppLifecycleState.inactive:
  //       print('AppLifecycleState.inactive');
  //       break;
  //     case AppLifecycleState.paused:
  //       print('AppLifecycleState.paused');
  //       break;
  //     case AppLifecycleState.resumed:
  //       print('AppLifecycleState.resumed');
  //       break;
  //     case AppLifecycleState.suspending:
  //       print('AppLifecycleState.suspending');
  //       break;
  //   }

  //   super.didChangeAppLifecycleState(state);
  // }



  //textfield 是否失去键盘焦点
  Future<Null> _focusNodeListener() async {
    // 用async的方式实现这个listener
    if (_focusNode.hasFocus) {
      setState(() {
        _hasDeleteBt = true;
      });
    } else {
      setState(() {
        _hasDeleteBt = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.supervised_user_circle,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(width: 8),
            Expanded(
                child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              focusNode: _focusNode,
              autofocus: false,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  suffixIcon: _hasDeleteBt
                      ? IconButton(
                          icon: Image.asset(
                            'image/clear.png',
                            width: 23,
                            height: 23,
                          ),
                          onPressed: () {
                            widget.controller.clear();
                          },
                        )
                      : Text('')),
            )),
          ],
        ),
      ),
    );
  }
}
