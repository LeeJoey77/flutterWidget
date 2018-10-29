import 'package:flutter/material.dart';
/*
1. 在 Flutter 中，widgets 是不可变的，而且不能被直接更新。你需要去操纵 widget 的 state。
2. StatefulWidget 和 StatelessWidget 区别:
StatefulWidget 拥有一个 State 对象来存储它的状态数据，并在 widget 树重建时携带着它，
因此状态不会丢失。如果你有疑惑，请记住以下规则：如果一个 widget 在它的 build 方法之外改变
(例如，在运行时由于用户的操作而改变), 它就是有状态的. 如果一个 widget 在一次 build 之后永远不变,
那它就是无状态的. 但是，即便一个 widget 是有状态的，包含它的父亲 widget 也可以是无状态的,
只要父 widget 本身不响应这些变化。
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