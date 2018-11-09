import 'package:flutter/material.dart';


/// 不需要 mutable state 的 widget
/// 
/// [StatelessWidget] 通过创建一个 other Widgets 的 constellation, 描绘了部分用户界面.
/// other widgets 更加具体的描绘了用户界面.
/// 
/// [StatelessWidget] 适用于所描绘的 UI 界面只依赖自身配置信息和 [BuildContext]的 widget.
/// 对于动态改变的 widget, 使用 [StatefulWidget]
/// 
/// ## Performance considerations
/// 
/// 1. 一般来说, stateless widget 的 [build] 方法只在三种情况下调用: widget 第一次插入 tree, 
/// widget 的 parent 改变配置, 它所依赖的 [InheritedWidget] 改变.
/// 
/// 2. 如果widget 的 parent 经常改变配置, 或者它所依赖的 [InheritedWidget] 改变, optimize 
/// [build] 方法的 performance 来维持流畅的 rendering performance 就很重要了.
/// 
/// 尽量减小 Stateless Widget 重建影响的技巧:
/// 1. 尽量减少 [build method] 和它创建的 widget 创建的过渡节点的数量.例如, 使用单 child 的
/// widget 布局单个视图.使用 [CustomPaint] widget 描绘图形效果, 而不是用许多层 Container.
/// 
/// 2. 尽可能使用 const, 并且用 `const` 标记该 widget 的 constructor, 以便提醒使用者也这样做.
/// 
/// 3. 将 stateless widget 重构为 Stateful widget, 以便它可以使用 Stateful widget 的一些技术,
/// 例如, caching subtree 的通用部分, 改变 tree 结构的时候使用 [GlobalKey].
/// 
/// 4. 如果由于使用了 [InheritedWidget], widget 可能经常 rebuild, 可以将该 stateless widget 
/// 分解为多个 widget. 例如, 相比于 build 一个有四个 widget, 最内层 widget 依赖于 [Theme] 的 
/// stateless widget, 可以将最内层 widget 的 build 方法提前出来, 单独创建, 这样 [Theme] 变化
/// 时, 就只有最内层 widget 需要改变.
/// 
/// 例: 
/// ```dart
/// class Frog extends StatelessWidget {
///   const Frog({
///     Key key,
///     this.color: const Color(0xFF2DBD3A),
///     this.child,
///   }) : super(key: key);
///
///   final Color color;
///
///   final Widget child;
///
///   @override
///   Widget build(BuildContext context) {
///     return Container(color: color, child: child);
///   }
/// }
/// ```
/// [widget constructor 中的每个参数对应一个 `final` 属性.]
/// 按照惯例, [constructor 的参数只使用 named arguments, named arguments 可以标记为 @required],
/// 第一个参数为 [key], 最后一个为 `child`, `children`或等价物
/// 
class StatelessWidgetSample extends StatelessWidget {
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
      body: Container(),
      backgroundColor: Color.fromRGBO(255, 100, 10, 1),
    );
  }
}