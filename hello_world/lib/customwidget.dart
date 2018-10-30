import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}