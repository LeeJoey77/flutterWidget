import 'package:flutter/material.dart';

//Container
//参考链接: https://juejin.im/post/5ba1af55e51d450ea3632ab4

//Container 定义:
// 一个方便的 Widget, 包含了常用的 painting, positioning, 和 sizing 的 widgets

/// Container 渲染:
/// 1. Container 会首先使用 [padding] 来围绕 [child]，
/// 2  然后对 [padded extent] 的添加额外的 [constraints](如果非空)，
/// 3. 然后 Container 被外部的空白区域 [margin]包围。
/// 4. 在绘制过程中，Container 首先应用变换 [transform]，
/// 5. 然后绘制装饰 [decoration] 来填充 [padded extent]，
/// 6. 接着绘制 [child]，
/// 7. 最后绘制前景装饰 [foregroundDecoration], 同时填充 [padded extent]

/// Container 布局规则:
/// 1.如果没有 [child], 没有设置 [width, height, constraint], 
/// 但父视图设置了 [unbounded] 约束, 尽可能小

/// 2.如果没有 [child], 没有 [alignment], 但是设置了 [width, height 或 constraint], Container 
/// 会根据自身和父视图的约束尽可能小

/// 3.如果没有 [child], 没有设置 [width, height, constraint], 没有 [alignment], 
/// 但父视图设置了 [unbounded] 约束, Container 会 expand to fit 父视图的约束

/// 4.如果有 [alignment], 并且父视图提供了 [unbounded] 约束, 
/// Container 会 size itself around the child

/// 5.如果有 [alignment], 并且父视图提供了 [bounded] 约束, 
/// Container 会 expand to fit 父视图, 并根据 [alignment] 布局子视图

/// 6.否则, 如果有 [child], 没有 [alignment], 没有 [width, height, constraint], 
/// Container 把父视图的约束传递给子视图, sizes itself to match the child

/// Container 属性:
/// 1.Widget child: 子视图
/// 如果为 null, 并且自身 [constraints] 为 unbounded 或者为 null, 
/// Container 会 expand 去填充父视图所有 available space.
/// 但是如果父视图提供 [unbounded constraints], Container 尽可能小

/// 2.AlignmentGeometry alignment: 在父视图中对齐 [align] child
/// 是对 child 的设置, 所以 child 为 null 时此属性无效
/// 如果 non-null, expand to fit 父视图并且根据给定的值布局子视图;
/// 但是如果 constraint 为 [unbounded], 则 child 被 shrink-wrapped, 即 Container 尽可能小
/// 一般用 [Alignment] 来设置

/// 3.EdgeInsetsGeometry padding: Empty space to inscribe inside the [decoration]

/// 4.Decoration decoration: The decoration to paint behind the [child]

/// 5.Decoration foregroundDecoration: The decoration to paint in front of the [child].

/// 6.BoxConstraints constraints: 添加在 child 上的约束
/// width, height 和 约束共同作用
/// [padding] 在 constraint 内部
  
/// 7.EdgeInsetsGeometry margin: [decoration] 和 [child] 之间的空白区域

/// 8.Matrix4 transform 

class ContainerWidget extends StatelessWidget {
  // bounded constraints
  @override
  Widget build(BuildContext context) {
    var imgUrl = "https://ws1.sinaimg.cn/large/006tNc79gy1fpa5bvsqskj3044048mx5.jpg";
    return new Container(
      //一. 没有 child, Container 会尽可能大, 但是 Container 作为 UnconstrainedBox 的 child 时, 没有约束会尽可能小
      //1. 没有约束, 尽可能大
      decoration: BoxDecoration(
        color: Colors.blue,
        image: new DecorationImage(
          //  image: new NetworkImage(imgUrl)//网络图片
          image: ExactAssetImage('image/Swiss-flag.jpg'),//本地图片
          fit: BoxFit.cover,
        ),
        border: new Border.all(
              color: Colors.yellowAccent,
              width: 10.0,
        ),
      ),

      //2. 宽高都为 min, 则尽可能大
      //宽高一个为 min, 一个没有设置, 则尽可能大
      // constraints: BoxConstraints(minWidth: 100.0, minHeight: 100.0),
      //宽高一个为 min, 一个为 max, 则 max 的值为 maxValue, min 的尽可能大
      //宽高一个为 max, 另一个没有设置, 则 max 的值为 maxValue, 没有设置的尽可能大
      //constraints: BoxConstraints(minWidth: 100.0, maxHeight: 100.0),
      //constraints: BoxConstraints(maxWidth: 100.0, minHeight: 100.0),

      //宽高都为 max, 则宽高都为 maxValue
      //constraints: BoxConstraints(maxWidth: 100.0, maxHeight: 100.0),

      //3. 没有约束, container 包住 child
      child: Text('containerDemo'),
      alignment: Alignment.topCenter,

      //二. 有 child, Container 让自身适应子控件
      //4. 设置高度为 100, 宽度没有约束, 则高度为100，宽度包住子组件
      //height: 200.0,
      //padding 等于 10 围绕 child 
      //padding: EdgeInsets.all(10.0),

      //5. 有 child, 设置高度为 100, 宽度设为无限, 则高度为100，宽度为屏幕宽度
      //有 child, 设置宽高设为无限, 则大小为屏幕大小
      //width: double.infinity,

      //6. margin
      //Container 和父视图之间的间隔为 20
      //margin: EdgeInsets.all(20.0),

      //7. transform
      transform: Matrix4.rotationZ(0.3),
    );
  }

  // unbounded constraint
  /*
  Widget build(BuildContext context) {
    return new UnconstrainedBox(
      child: Container(
        color: Colors.blue,
        child: Text('containerDemo'),
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(20.0),

      )
    );
  }
  */
  
}