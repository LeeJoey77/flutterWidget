import 'package:flutter/material.dart';

class RowAndColumnSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return _rowSample();
    return _columnSample();
    // return _stackSample();
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
/// Row 的布局顺序
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
  /**/
  
  /// 上例中 text 和 logo 都是 center 对齐, 下例中, [crossAxisAlignment] 被设置为
  /// [CrossAxisAlignment.start], 所以 children 为左对齐. [mainAxisSize] 被设置为
  /// [MainAxisSize.min], 所以 column 会 shrink to fit the children
  /*
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('We move under cover and we move as one'),
        // Text('Through the night, we have one shot to live another day'),
        // Text('We cannot let a stray gunshot give us away'),
        // Text('We will fight up close, seize the moment and stay in it'),
        // Text('It’s either that or meet the business end of a bayonet'),
        // Text('The code word is ‘Rochambeau,’ dig me?'),
        Text('Rochambeau!'),
      ],
    ),
  );
  */
}

Widget _stackSample() {
  return Stack();
}
