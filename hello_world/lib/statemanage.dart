import 'package:flutter/material.dart';

/*
StatefulWidget 的 State 管理:
1. widget 管理自己的 State
2. 父 widget 管理 widget 的 State
3. 混合管理

State 管理方法选择:
1. 如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父widget管理
2. 如果所讨论的状态是有关界面外观效果的，例如动画，那么状态最好由widget本身来管理.
3. 如果不确定，首选是在父widget中管理状态
*/

/*
// widget 管理自己的 State
class CustomWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final kScreenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('image/Swiss-flag.jpg', width: kScreenWidth, fit: BoxFit.fill,),
          _titleRow(),
          _buttonRow(),
          _detailText(),          
        ],
      ),
    );
  }
}

Widget _titleRow() {
  return Padding(
    padding: EdgeInsets.only(left: 30, top: 15, right: 30, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Oeschinen Lake Campground', 
              style: TextStyle(fontSize: 17, color: Colors.black87)),
              Text('Kandersteg, Switzerland',
              style: TextStyle(fontSize: 15, color: Colors.black54)),
            ],
          ),
        ),
        FavoriteWidget(),
      ],
    )
  );
  
}

class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({Key key}) : super(key: key);
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
        if (_isFavorited) {
          _favoriteCount -= 1;
          _isFavorited = false;
        } else {
          _favoriteCount += 1;
          _isFavorited = true;
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Card(// IconButton 的父类必须为 Material
          elevation: 0,
          margin: EdgeInsets.all(2),
          child: IconButton(
            icon: _isFavorited
             ? Icon(Icons.star)
             : Icon(Icons.star_border),
            color: Colors.red,
            onPressed: _toggleFavorite,
          ),
        ),
        //当文本在40和41之间变化时，将文本放在SizedBox中并设置其宽度可防止出现明显的“跳跃” 
        //，因为这些值具有不同的宽度。
        SizedBox(
          width: 20,
          child: Text('$_favoriteCount',
           style: TextStyle(fontSize: 15, color: Colors.black54),),
        ),
       ],
    );
  }
}

Widget _buttonRow() {
  return Padding(
    padding: EdgeInsets.only(left: 50, top: 15, right: 50, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Icon(Icons.phone, color: Colors.blue,),
              Text('CALL',
                style: TextStyle(fontSize: 15, color: Colors.blue),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Icon(Icons.navigation, color: Colors.blue,),
              Text('ROUTE',
                style: TextStyle(fontSize: 15, color: Colors.blue),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Icon(Icons.share, color: Colors.blue,),
              Text('SHARE',
                style: TextStyle(fontSize: 15, color: Colors.blue),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _detailText() {
  return Padding(
    padding: EdgeInsets.only(left: 20, right: 30, bottom: 15, top: 15),
    child:  Text('''a name meaning "first day of winter".For the Celts, the day ended and began at sunset; 
                thus the festival began on the evening before 
                7 November by modern reckoning (the half point 
                between equinox and solstice). Samhain 
                and Calan Gaeaf are mentioned in some of the 
                earliest Irish and Welsh literature. 
                The names have been used by historians
                to refer to Celtic Halloween customs up until
                the 19th century, and are still the Gaelic 
                and Welsh names for Halloween.''',
                style: TextStyle(fontSize: 15, color: Colors.black54),
                overflow: TextOverflow.clip,
    ),
  );
}
*/

/*
//父 widget 管理 widget 的 State

// ParentWidgetState 类:
// 为TapboxB 管理_active状态.
// 实现_handleTapboxChanged()，当盒子被点击时调用的方法.
// 当状态改变时，调用setState()更新UI.

// TapboxB 类:
// 继承StatelessWidget类，因为所有状态都由其父widget处理.
// 当检测到点击时，它会通知父widge
// 父 widget 管理 widget 的 state
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState((){
      _active = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
      
    );
  }
}

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
  : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(color: Colors.white)
          )
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}
*/


// 混合管理
/*
对于一些widget来说，混搭管理的方法最有意义的。在这种情况下，有状态widget管理一些状态，
并且父widget管理其他状态。
在TapboxC示例中，点击时，盒子的周围会出现一个深绿色的边框。取消点击时，边框消失，盒子的颜色改变。
 TapboxC将其_active状态导出到其父widget中，但在内部管理其_highlight状态。
 这个例子有两个状态对象_ParentWidgetState和_TapboxCState。

_ParentWidgetState 对象:

管理_active 状态.
实现 _handleTapboxChanged(), 当盒子被点击时调用.
当点击盒子并且_active状态改变时调用setState()更新UI
_TapboxCState 对象:

管理_highlight state.
GestureDetector监听所有tap事件。当用户点下时，它添加高亮（深绿色边框）；当用户释放时，会移除高亮。
当按下、抬起、或者取消点击时更新_highlight状态，调用setState()更新UI。
当点击时，将状态的改变传递给父widget.
*/

class ParentCWidget extends StatefulWidget {
  @override
  _ParentCWidgetState createState() => _ParentCWidgetState();
}

class _ParentCWidgetState extends State<ParentCWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState((){
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          child: TapboxC(
            active: _active,
            onChanged: _handleTapboxChanged,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged})
    : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  _TapboxCState createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;   
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }
  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32),),
        ),
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight ? Border.all(
            color: Colors.teal[700],
            width: 10
          )
          : null,
        ),
      )
      
    );
  }
}
