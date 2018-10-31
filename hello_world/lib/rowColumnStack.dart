import 'package:flutter/material.dart';

class RowAndColumnSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return _rowSample();
    // return _columnSample();
    // return _stackSample();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // child: _expandedSample(),
        child: _stackSample(),
      ),
    ); 
  }
}

/// Row: 一个横向布局 [children] 的 Widget
/// 
/// 为了让 child expand to fill 可得的横向空间, 将 child wrap 在一个 [Expanded] widget 中
/// 
/// Row 不会滚动, 如果一行 widget 要滚动, 而且没有足够的空间, 使用 [ListView]
/// 
/// 如果只有一个 child, 使用 [Align] 或 [Center] 去布局
/// 
/// Row 布局顺序:
/// 1. 根据 unbounded 水平约束, 布局 flex 为 null 或 0 的 child(例如those are not [Expanded]). 
/// 如果 [crossAxisAlignment] 为[CrossAxisAlignment.stretch], 使用 match 最大高度的 [tight] 
/// vertical constraint
/// 
/// 2. 在flex 为 non-zero 的 children(例如those are [Expanded]) 中根据 flex 值划分剩余空间, 
/// 例如, 一个 child flex 值为 2.0, 划分的横向空间比 flex 为 1 的大两倍
/// 
/// 3. 以和步骤 1 相同的 vertical constraint 布局剩余的 children, 但是 horizontal constraint值 
/// 不是 unbounded, 而是基于第二步中 allocated 的空间. 
/// 如果 Children [Flexible.fit] 属性的值 为 [FlexFit.tight], children are given tight constraint
/// (例如: 强制填充 allocated 空间);
/// 如果 Children [Flexible.fit] 属性的值 为 [FlexFit.loose], children are given loose constraint
/// (例如: 不会强制填充 allocated 空间);
/// 
/// 4. Row 的 height 是 children 中最大高度的值(这一高度在始终满足 vertical constraint)
/// 
/// 5. Row 的宽度由 [mainAxisSize] 决定, 如果 [mainAxisSize] 值为 [mainAxisSize.max], 则 width 为
/// incoming constraint 的最大值.如果 [mainAxisSize] 值为 [mainAxisSize.min], 则 width 置为 children 
/// 宽度的和
/// 
/// 6. 每个 child 的位置由 [mainAxisAlignment] 和 [crossAxisAlignment] 共同决定, 例如, 如果
/// [mainAxisAlignment] 值为 [MainAxisAlignment.spaceBetween], 水平空间中剩余部分被平分
/// 
/// Row constructor:
/// [direction], [mainAxisAlignment], [mainAxisSize], [crossAxisAlignment], [verticalDirection]
/// 不能为 null; 如果 [crossAxisAlignment] 为 [CrossAxisAlignment.baseline], 则 [textBaseline]
/// 不能为 null.
/// 
/// [textDirection] 默认为 ambient [Directionality]; 如果没有 ambient [Directionality], 需要有 
/// text direction 决定布局顺序或者消除 [mainAxisAlignment] `start`, `end` 值的歧义, [textDirection] 
/// 不能为 null
/// 

Widget _rowSample() {
  //例1: 横向空间分为三份, 前两个是 text, 第三个是 logo
  return Container(
    color: Colors.white,
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text('Deliver features faster', textAlign: TextAlign.center,),
        ),
        Expanded(
          child: Text('Craft beautiful UIs', textAlign: TextAlign.center,),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain,
            child: const FlutterLogo(),
          ),
        ),
      ],
    ),
  );
  

  /// 如果第一个 Text 不 wrap 在 Expanded 中, Text 宽度尽可能长, Row 会 overflow
  /// ### 黑黄相间的警示条
  /// 如果 Row 的 non-flexible 内容(没有 wrapped 在 [Expanded] 或 [Flexible] 中的 widget), 
  /// 加在一起, 宽度超过了 Row 本身, 就说 Row overflow 了.当一个 Row overflow, Row 没有剩余
  /// 的空间给其它 children, 这时 overflow 的一边会出现一个黑黄相间的警示条. 如果 Row 以外没有空间
  /// (已经到达屏幕边缘), overflow 的内容会以红字显示在警示条上
}


Widget _columnSample() {
  /*
  return Container(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        Text('Deliver features faster'),
        Text('Craft beautiful UIs'),
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain,
            child: const FlutterLogo(),
        ),)
      ],
    ),
  );
  */

  /// 上例中 text 和 logo 都是 center 对齐, 下例中, [crossAxisAlignment] 被设置为
  /// [CrossAxisAlignment.start], 所以 children 为左对齐. [mainAxisSize] 被设置为
  /// [MainAxisSize.min], 所以 column 会 shrink to fit the children
  
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('We move under cover and we move as one'),
        Text('Rochambeau!'),
      ],
    ),
  );
  /**/

  /// 当 vertical constraints 是 unbounded:
  /// 
  /// 当一个 [Column] 有一个或多个 [Expanded] 或 [Flexible] children, 并且这个
  /// [Column] 被置于另一个 [Column] 或 [ListView] 或其它没有给 [Column] 提供
  /// 最大高度限制的 context, 会抛出一个异常: children flex 为 non-zero, 但是 vertical 
  /// constraint 为 unbounded.
  /// 
  /// 问题在于使用 [Flexible] or [Expanded] 意味着在布局完所有其它 children 后的剩余空间会被平分, 
  /// 但是如果 vertical constraint 为 unbounded, 剩余的空间为无限
  /// 
  /// 解决问题的关键是确定 [Columen] receive unbounded vertical constraint 的原因
  /// 这种情况发生的常见原因是 [Column] 被置于另一个 [Column], 但是内置的 [Column] 没有使用 [Expanded]
  /// 或 [Flexible]. 当一个 [Column] 布局 non-flex children(没有使用 [Expanded] 或 [Flexible]的 children),
  /// 这个 [Column] 会给 children unbounded 的 constraint, 以便它们可以决定自己的大小(传递 UNbounded constraint 
  /// 通常意味着告诉 child 它应该 shrink-wrap 它的内容).一般来说, 这种情况的解决办法是对内置的 [Column] 使用
  /// [Expanded] 来表明它应该占据外部 [Column] 剩余的空间, 而不是占据它想要大小的空间
  ///
  /// 这个 message 出现的另一个原因是 [Column] 被置于一个 [ListView] 或者其它 vertical scrollable.
  /// 在这个场景中, vertical space 确实是无限的, 通常需要考虑为什么内置的 [Column] 需要 [Expanded] or [Flexible]
  /// child, 内部 children 尺寸应该多少? 一般来说, 解决办法是移除内部 children 的 [Expanded] or [Flexible] widgets
  /// 
  /// ### 黑黄相间的警示条
  /// 当 [Column] 的内容超过了可利用的高度, [Column] overflow, contents 被 clipped.
  /// 
  /// 通常的解决办法是改用 [ListView]
  /// 
  /// Column 布局顺序同 Row
}

/// 一个 widget 用来 expands [Row], [Column], or [Flex] 的 child
/// 使用 [Expanded] widget 让 [Row], [Column], or [Flex] 的 child expand to fill
/// the available space in the main axis. 
/// 如果多个 children 是 expanded, the available space 按照 [flex] 的值被划分
/// 
/// [Expanded] widget 必须是 [Row], [Column], or [Flex] 的 descendant, 并且从 
/// [Expanded] widget 所在 [Row], [Column], or [Flex] 的路径必须都是[StatelessWidget]s
/// or [StatefulWidget]s, 不能是其它 widget, 例如[RenderObjectWidget]s
///  
/// 
Widget _expandedSample() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Icon(Icons.email),
      ),
      Image.asset('image/Swiss-flag.jpg',
        height: 100,
        width: 100,
        fit: BoxFit.fill,
      ),
      Expanded(
        child: Text('mainAxisAlignmentmainAxisAlignmentmainAxisAlignmentmainAxisAlignment', style: TextStyle(fontSize: 15),),
      ),
    ],
  );
}

/// Stack: 根据 box edges 布局 children 的 widget
/// 
/// 适用于 overlap 的 children 布局.
/// 
/// [Stack] 的 child 要么是 _positioned_ 要么是 _non-positioned_:
/// 
/// Positioned children 是 wrap 在[Positioned] widget(至少一个属性不为 null) 中的 children.
/// 
/// stack sizes itself to contain 所有 non-positioned children, non-positioned children
/// 根据 [alignment] 布局(在 left-to-right 语境中默认在左上角, 在 right-to-left 语境中默认在
/// 右上角.) 然后根据 top, right, bottom, left 布局 positioned children.
/// 
/// stack 将第一个 child 绘制在底部, 如果想改变绘制顺序, 需要改变 children 顺序 重建 stack.
/// 如果以这种方式给 children 重新排序, 要给 children 一个 non-null 的 key. 这些 key 使
/// framework 将 children 移到新的位置, 而不是在新位置重新创建它们.
/// 
/// 如果想要以某种 pattern 布局大量 children, 或者想自定义 layout manager, 可以使用 
/// [CustomMultiChildLayout]. 特别是, 当不能根据 children 自身 size 或 stack size 
/// 布局 children 时.
/// 
Widget _stackSample() {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Image.asset('image/Swiss-flag.jpg',
        width: 100,
        height: 100,
        fit: BoxFit.fill,
      ),
      Text('afdafdaflanfalfknvmnv', style: TextStyle(fontSize: 15),)
    ],
  );
}
