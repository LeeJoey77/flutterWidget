import 'package:flutter/material.dart';


/// 带有可变 State 的 Widget
///
/// 
/// State 是 information, 这个 information 中的 (1) 可以在 Widget 创建时被同步读取,
/// (2) 也许会在 Widget 的生命周期中改变.
/// widget implementer(即 StatefulWidget 的 build 方法) 的责任就是确保将 state 的改变,
/// 通过调用 [State.setState()] 方法及时通知 [State]
/// 
/// [StatefulWidget] 通过创建一个 other Widgets 的 constellation, 描绘了部分用户界面.
/// other widgets 更加具体的描绘了用户界面.
/// 
/// [StatefulWidget] 适用于部分 UI 界面动态变化的场景. 只依靠自身配置信息的使用 [StatelessWidget]
/// [StatefulWidget] widget 实例是不可变的, 它的状态可变, 单独存储, 
/// 要么存储在在一个[createState] 方法创建的 [State] 对象中, 要么存储在
/// [State] subscribes to 的对象中, 例如 [Stream] or [ChangeNotifier], 这些对象的指针
/// 存储在 [StatefulWidget] 的 final fields 中
/// 
/// framework inflate [StatefulWidget] 时调用 [createState] 方法, 这意味着当 [StatefulWidget]
/// 被插入 Widget tree 的多个位置时, 会有多个 [State] 与之关联.
/// 同样地, 当一个 [StatefulWidget] 被从 Widget tree 上移除然后再次插入时, framework 会
/// 调用 [createState] 方法创建一个新的 [State], 简化 [State] 的生命周期.
/// 
/// 如果一个 Widget 的 创建者使用 [GlobalKey] 作为它的 key, Widget 在 widget 中移动位置时
/// widget 的 [State] 保持不变.因为一个带有 [GlobalKey] 的 widget, 最多只能出现在 widget tree
/// 中的一个位置. 使用 [GlobalKey] 的 widget 最多只能关联一个 element.
/// 在将一个 widget 从一个位置移到另一个位置时, 可以利用这一性质, 将与该 widget 关联的 (unique) 的
/// subtree 从一个位置移动到另一个位置, 而不是重新创建.同时, 与该 widget 关联的 [State] 也会
/// 随着 subtree 被移植, 这意味着 [State] 将会被重新使用而不是重新创建.
/// 然而, 为了让 subtree 的移植合法, widget 必须被插入同一个 animation frame, 即和移除时
/// 相同的 animation frame.
/// 
/// ## Performance considerations
/// 有两类主要的 [StatefulWidget]:
/// 第一类是在 [State.initState] 中开辟空间, 在 [State.dispose] 中释放, 但是不依赖 
/// [InheritedWidget], 不调用 [State.setState] 的 widget.
/// 这类 widget 通常用在 application 或 page 的 root, 通过 [ChangeNotifier], [Stream]之类
/// 的对象和 subwidgets 通信.考虑到 CPU and GPU cycles, 它们是相对 cheap 的, 因为它们只
/// 创建一次, 不会更新, 因此可以有复杂的深度的 build 方法.
/// 
/// 第二类是 依赖 [InheritedWidget], 调用 [State.setState] 的 widget.一般来说, 在 widget 的
/// 声明周期中, 它们会被重建多次.因此尽量减小重建的影响十分重要. 它们也行也使用 [State.initState] or
/// [State.didChangeDependencies] and allocate resources, 但重要的是它们会重建.
/// 
/// 尽量减小重建影响的技巧:
/// 1. Push the state to the leaves
/// 如果界面上一个 ticking clock, 不要把它放在页面 top 每次 tick 时更新整个界面, 而是创建一个
/// dedicated 的 clock, 让它只更新自己
/// 
/// 2. 尽量减少 [build method] 和它创建的 widget 创建的过渡节点的数量.
/// 理想情况下, 一个 StatefulWidget 只创建一个 Widget, 即 [RenderObjectWidget].虽然实际并不
/// 总是如此, 但是越接近理想状态越好.
/// 
/// 3. 如果一个 Widget 的 subtree 不改变, cache 该 Widget, 并且重用它.
/// 除了同样配置的 Widget, 重用 Widget 比创建一个新的 Widget 更加高效.一个常用的做法是, 将
/// stateful 的 Widget 提取出来, 作为 child.
/// 
/// 4. 尽可能使用 const, 使用 const 相当于缓存该 Widget 并重用.
/// 
/// 5. 避免改变 subtree 的深度以及 subtree 中 widget 的类型.例如, 返回一个 child 时, 如果有
/// 直接返回和 wrap 在 [IgnorePointer] 中两种选择, 总是选择 wrap 在 [IgnorePointer]中, 并且
/// 控制 [IgnorePointer.ignoring] 属性.因为改变 subtree 的深度需要 rebuild, lay out, paint
/// 整个 subtree, 然后改变 property, render tree 的改变最小.
/// 
/// 6. 如果因为某种原因, 不得不改变 subtree 的深度, 将 subtree 的通用部分 wrap 在带有 [GlobalKey]
/// 的 widget 中, [GlobalKey] 和 stateful widget 的 life 保持一致.如果没有 widget 可以被赋值 key,
/// 可以使用 [KeyedSubtree] widget.
/// 
/// 例子:
/// 
/// ```dart
/// class YellowBird extends StatefulWidget {
///   const YellowBird({ Key key }) : super(key: key);
///
///   @override
///   _YellowBirdState createState() => _YellowBirdState();
/// }
///
/// class _YellowBirdState extends State<YellowBird> {
///   @override
///   Widget build(BuildContext context) {
///     return Container(color: const Color(0xFFFFE306));
///   }
/// }
/// ```
/// 
/// 上例中, [State] 没有实际的 state, [state 通常是私有的变量]. [Widget 的属性为 final 值]
/// 
/// 下例中, widget `Bird` 有一个内部 state, 并且有一个方法可以调用改变它
/// 
/// ```dart
/// class Bird extends StatefulWidget {
///   const Bird({
///     Key key,
///     this.color: const Color(0xFFFFE306),
///     this.child,
///   }) : super(key: key);
///
///   final Color color;
///
///   final Widget child;
///
///   _BirdState createState() => _BirdState();
/// }
///
/// class _BirdState extends State<Bird> {
///   double _size = 1.0;
///
///   void grow() {
///     setState(() { _size += 0.1; });
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Container(
///       color: widget.color,
///       transform: Matrix4.diagonal3Values(_size, _size, 1.0),
///       child: widget.child,
///     );
///   }
/// }
/// ```
/// 
/// 按照惯例, [constructor 的参数只使用 named arguments, named arguments 可以标记为 @required],
/// 第一个参数为 [key], 最后一个为 `child`, `children`或等价物
/// 
/// [State 的 state 通常是私有的变量].
/// [Widget 的属性为 final 值]
/// 
/// StatefulWidget 方法:
/// 
/// 1.
/// 创建一个 [StatefulElement] 管理这个 Widget 在 tree 中的位置
/// 子类一般不 override 这个方法
/// @override
/// StatefulElement createElement() => StatefulElement(this);
/// 
/// 2. 
/// 在给定位置为 Widget 创建可变的 state, 子类应该 override 这个方法返回一个新建的对象.
/// 在 [StatefulWidget] 的生命周期中, framework 可能多次调用这个方法.例如, 一个 Widget 被插入到 tree 中
/// 的多个位置, framework 会为每个位置创建一个单独的 [State].同样地, 当一个 [StatefulWidget] 
/// 被从 Widget tree 上移除然后再次插入时, framework 会调用 [createState] 方法创建一个新的 [State],
///  简化 [State] 的生命周期.
/// @protected
///  State createState();
/// 
/// State 生命周期:
/// enum _StateLifecycle {
///   [State] 对象被创建, [State.initState] 在此时调用
///   created,

///   [State.initState] 方法被调用, 但是 [State] 对象没有准备好 build. [State.didChangeDependencies] 
///   在此时被调用
///   initialized,

///   [State] 对象准备好 build, [State.dispose] 还没被调用
///   ready,

///   [State.dispose] 被调用, [State] 对象不能再被 build
///   defunct,
/// }

/*
1. widgets 是 immutable，不能被直接更新. 你需要去操纵 widget 的 state.
2. StatefulWidget 和 StatelessWidget 区别:
StatefulWidget 拥有一个 State 对象来存储它的状态数据，它和widget的布局显示分离,
并在 widget 树重建时携带着它， 因此状态不会丢失。
如果一个 widget 在它的 build 方法之外改变(例如，在运行时由于用户的操作而改变), 它就是有状态的. 
如果一个 widget 在一次 build 之后永远不变,那它就是无状态的. 但是，即便一个 widget 是有状态的, 
包含它的父亲 widget 也可以是无状态的, 只要父 widget 本身不响应这些变化。
当widget状态改变时, State 对象调用setState(), 告诉框架去重绘widget.
*/

/*
创建一个 stateful widget:
1. 决定哪个 widget 管理 widget 的 state
2. 创建 StatefulWidget 子类
3. 创建 State 子类
4. 将 stateful widget 插入到 widget 树中
*/

/*
class StatefulSample extends StatefulWidget {
   StatefulSample({Key key}) : super(key: key);
   @override
   _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<StatefulSample> {
  // Default placeholder text
  String textToShow = "I Like Flutter";
  void _updateText() {
    setState(() {
      // update the text
      textToShow = "Flutter is Awesome!";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(child: Text(textToShow)),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: Icon(Icons.update),
      ),
    );
  }
}
*/

/*
class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallBack(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
   ShoppingListItem({Product product, this.inCart, this.onCartChanged})
   : product = product,
   super(key: new ObjectKey(product));
   
   final Product product;
   final bool inCart;
   final CartChangedCallBack onCartChanged;

   Color _getColor(BuildContext context) {
     return inCart ? Colors.black54 : Theme.of(context).primaryColor;
   }

   TextStyle _getTextStyle(BuildContext context) {
     if (!inCart) return null;
     return new TextStyle(
       color: Colors.black54,
       decoration: TextDecoration.lineThrough,
     );
   }

   @override
   Widget build(BuildContext context) {
     return new ListTile(
       onTap: () {
         onCartChanged(product, !inCart);
       },
       leading: new CircleAvatar(
         backgroundColor: _getColor(context),
         child: new Text(product.name[0]),
       ),
       title: new Text(product.name, style: _getTextStyle(context)),
     );
   }
}

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);
  final List<Product> products;
  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();
  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
        if (inCart) {
          _shoppingCart.add(product);
        } else {
          _shoppingCart.remove(product);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
*/
