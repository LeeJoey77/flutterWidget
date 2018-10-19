import 'package:flutter/material.dart';



/// MaterialApp: 一个使用 material design 的 application
/// 
/// 一个便利的 Widget, 包含了许多 material design applications 常用的 Widget.
/// 创建在 [WidgetsApp] 的基础上, 添加了 material-design 的具体功能,
///  如 [AnimatedTheme] 和 [GridPaper]
/// 
/// MaterialApp 按照以下顺序配置 top-level [Navigator] 寻找 routes 进行导航
/// 1. 对于 `/` route, 如果 [home] 不为 null, 则使用 home
/// 2. 否则使用 [routes] 列表, 它有一个 route 的入口
/// 3. 否则如果提供了 [onGenerateRoute] 则调用, 会返回一个 non-null value for 
/// any _valid_ route not handled by [home] and [routes]
/// 4. 如果以上都失败, 调用 [onUnknownRoute]
/// 
/// 如果 [Navigator] 被创建, 上述选项中至少有一个必须处理 `/` route, 
/// 因为它会在一个无效的 [initialRoute] startup 时被使用
/// 
/// MaterialApp 必须设置 top-level [Navigator] 的 observer 来执行 [Hero] 动画
/// 
/// 如果 [home], [routes], [onGenerateRoute], [onUnknownRoute] 都为 null,
/// 而 [builder] 不为 null, 则 [Navigator] 不会被创建

class materialAppSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
     

    );
  }
}