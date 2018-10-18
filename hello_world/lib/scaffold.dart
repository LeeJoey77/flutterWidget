import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/// Scaffold:
/// 实现了基本的 material design visual layout structure,
/// 提供了实现 drawers, snack bars, bottom sheets 的 API
/// 要展示 snackbar 或者持续的 bottom sheet, 需要通过 Scaffold.of 
/// 为当前的 BuildContext 获取 ScaffoldState, 并且调用 ScaffoldState.showSnackBar 
/// 和 ScaffoldState.showBottomSheet 函数

/// Scaffold 属性:
/// 1. PreferredSizeWidget appBar: 位于 Scaffold 顶部, 相当于 NavigationBar
/// 
/// 2. Widget body: Scaffold 的 content, 在 appBar 下方, 层级在
/// [floatingActionButton] 和 [drawer] 之后, 为了避免 body 被 resize, 要避免 window padding,
/// 参考 [resizeToAvoidBottomPadding].
/// 
/// 作为 body 的 Widget, 默认位置在左上方, 要想放在中间可以将这个 Widget 放在 Center Widget 中, 
/// 将 Center Widget 作为 body; 要想 expand 这个 Widget, 将它放在 [SizedBox.expand]中.
/// 
/// 如果有一列 Widget, 需要 fit on Screen, 并且滚动, 但是有可能 overflow, 使用 [ListView] 
/// 作为 body, [ListView] 也适用于滚动 List
/// 
/// 3. Widget floatingActionButton: 一个 floating above [body] 的按钮, 位于右下方
/// 
/// 4. FloatingActionButtonLocation floatingActionButtonLocation: [floatingActionButton] 
/// 的位置, 如果为 null, 则使用默认位置 [FloatingActionButtonLocation.endFloat]
/// 
/// 5. FloatingActionButtonAnimator floatingActionButtonAnimator: [floatingActionButton]
/// 移动到一个新的 [floatingActionButtonLocation] 的动画, 如果为 null, 则使用默认值
/// [FloatingActionButtonAnimator.scaling]
/// 
/// 6. List<Widget> persistentFooterButtons: 位于 Scaffold 底部的按钮组合, 一般是一列
/// [FlatButton] widgets, 这些按钮持续可见, 即使 body 滚动的时候
/// 
/// 这些 Widget 被 wrapped 在一个 [ButtonBar]中
/// 
/// [persistentFooterButtons] 被渲染在 [bottomNavigationBar] 之上, [body] 之下
/// 
/// 7. Widget drawer: 展示在 body 侧面的 panel, 通常是隐藏的, 可以从左到右 [TextDirection.ltr]
/// 或者从右到左 [TextDirection.rtl] 滑出
/// 
/// 如果想要手动打开, 调用 [ScaffoldState.openDrawer] 函数
/// 
/// 8. Widget endDrawer: 同上, 但手动打开时调用 [ScaffoldState.openEndDrawer] 函数
/// 
/// 9. Color backgroundColor: [Material] widget 的颜色, theme 默认为
///  [ThemeData.scaffoldBackgroundColor]
/// 
/// 10. Widget bottomNavigationBar: 位于 Scaffold 底部的 navigation bar
/// 
/// Snack Bar 从 bottomNavigationBar 下部滑出, bottom sheets 则被 stacked on top
/// 
/// bottomNavigationBar 被渲染在 [persistentFooterButtons] 和 [body]之下
/// 
/// 11. Widget bottomSheet: 持续展示的 bottom sheet
/// 
/// 持续展示的 bottom sheet 提供了一些信息, 补充 app 的 content, 在用户和其它部分交互时仍可见
/// 
/// 相关的 Widget 是 [modal bottom sheet], 它是 menu 或 dialog 的替代品, 用来阻止用户和其它部分交互
/// [modal bottom sheet] 可以被创建并用 [showModalBottomSheet] 函数展示
/// 
/// 和使用 [showBottomSheet] 函数展示的 bottom sheet 不同, 这里的 bottom sheet 不是一个
/// [LocalHistoryEntry], 也不能用 scaffold appbar 的 返回按钮 dismiss
/// 
/// 如果使用 [showBottomSheet] 创建的 bottom sheet 已经可见, 在创建一个带有 [bottomSheet] 的 Scaffold
/// 之前, 它必须被关闭
/// 
/// [bottomSheet] 可以是任何 Widget, 但实际上它不可能是 [BottomSheet], [BottomSheet] 用于
///  [showBottomSheet] and [showModalBottomSheet] 的实现中. 一般来说它是一个包含 [Material] 的 Widget
/// 
/// 12. bool resizeToAvoidBottomPadding: [body] 以及其它的 floating widgets 是否应该 size themselves
/// 避免 window's bottom padding
/// 
/// 例如当键盘出现在 scaffold 之上时, body 可以被 resized 来避免和键盘 overlap,
/// 防止body 中的 Widget 被遮挡
/// 
/// 默认为 true
/// 
/// 13. bool primary: Scaffold 是否被展示在屏幕的最上层
/// 
/// 如果为 true, [appBar] 会被 status bar 的高度 extended, 也就是 the top padding for [MediaQuery]
/// 默认值和 [AppBar.primary] 一样为 true


class ScaffoldWidget extends StatelessWidget {
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
              print('onpressed');
            },
          )
        ],
      ),
      body: _scaffoldBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Image.asset('image/Swiss-flag.jpg'),
        clipBehavior: Clip.antiAlias,//抗锯齿
        onPressed: (){
          print('floatingActionButton');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // persistentFooterButtons: _footerButtons(),
      drawer: _createDrawer(),
      backgroundColor: Color.fromRGBO(255, 100, 10, 1),
      bottomNavigationBar: _createBottomNavigationBars(),
      // bottomSheet: _createBottomSheet(),
    );
  }
}

Widget _scaffoldBody() {
  return new Center(
        child: new Container(
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(
              color: Color.fromRGBO(10, 255, 10, 1),
              width: 5,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          width: 200.0,
          height: 200,
        ),
      );
}

List<Widget> _footerButtons() {
  return <Widget>[
        CupertinoButton(
          child: new Text('button'),
          color: Colors.lightBlue,
          onPressed: (){
            print('button1');
          },
        ),
        CupertinoButton(
          child: new Text('button'),
          color: Colors.lightBlue,
          onPressed: (){
            print('button2');
          },
        ),
      ];
}

Widget _createDrawer() {
  return Drawer(
    child: ListView.separated(
      itemBuilder: (BuildContext context, int index){
        return new Container(
          color: Colors.white,
          height: 44,
          alignment: Alignment.centerLeft,
          child: Text('$index'),
        );
      },
      separatorBuilder: (BuildContext context, int index){
        return new Container(
          color: Colors.grey,
          height: 1,
        );
      },
      itemCount: 5,
    ),
    semanticLabel: 'adfa',
  );
}

//
Widget _createBottomNavigationBars() {
  return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Icon(Icons.fastfood),
            title: Text('Swiss'),
            backgroundColor: Colors.blue,
            // activeIcon: new Icon(Icons.fast_forward),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.flag),
            title: Text('Swiss'),
            activeIcon: new Icon(Icons.fast_forward),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.question_answer),
            title: Text('Swiss'),
            activeIcon: new Icon(Icons.fast_forward),
            backgroundColor: Colors.blue,
          )
        ],
        onTap: (index){
          print('$index');
        },
        currentIndex: 0,
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
      );
}

Widget _createBottomSheet() {
 return BottomSheet(
          onClosing: () {
            print('即将关闭');
          },
          builder: (BuildContext context){
            return new TextField(
              decoration: InputDecoration(
                icon: new Icon(
                  Icons.favorite,
                  size: 30,
                  color: Colors.pink,
                ),
                labelText: 'textfield',
                helperText: 'anything',
              ),
            );
          },
        );
}