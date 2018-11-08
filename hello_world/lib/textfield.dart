import 'package:flutter/material.dart';


/// onChanged text 改变时被调用, onSubmitted 点击按钮结束输入时调用.
/// [controller] 控制 text, 例如设置初始值, 控制选中, 组合(composing).
/// 默认地, textfield 有一个 [decoration] 在 textfield 下方画一条下划线, [decoration] 可以
/// 设置 icon, label. 也可以将 [decoration] 设为 null, [decoration] 将整个移除, 包括由 [decoration]
/// 引进的 padding
/// 如果 [decoration] 不为 null, textfield 的一个 ancestor 必须为 [Material] widget
/// 把  [TextField] 整合进 [Form], 可以使用 [TextFormField]
/// [maxLines] 默认为 1, 不能为 0
/// [maxLength] 默认为 null, 即没有限制.如果 [maxLength] 被设置, 一个 character counter 将会
/// 显示在 textfield 下方, 当输入达到 [maxLength], 多余的输入被忽略, 除非 [maxLengthEnforced]设置为 false
/// 如果 [maxLengthEnforced] 为 false, 输入的字符个数可以超过 [maxLength]
/// [textAlign], [autofocus], [obscureText], [autocorrect],
/// [maxLengthEnforced], [scrollPadding], [maxLines], [maxLength],
/// and [enableInteractiveSelection] 不能为 null
/// 
/// 属性:
/// TextEditingController controller: 控制输入的 text
/// FocusNode focusNode: 控制是否让键盘 focus
/// InputDecoration decoration: 见上方
/// TextInputType keyboardType: 键盘类型
/// TextCapitalization textCapitalization: 大写
/// TextStyle style: text style
/// 
class TextFieldSample extends StatefulWidget {
  @override
  _TextFieldSampleState createState() => _TextFieldSampleState();
}

class _TextFieldSampleState extends State<TextFieldSample> {

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 350),
          child: TextField(
            onChanged: (str) {

            },
            // onSubmitted: widget.onChanged,
            controller: _controller,
            autofocus: false,
            decoration: InputDecoration(
              
              hintText: '请输入用户名',
              icon: Icon(Icons.account_box),
              // suffix: IconButton(
              //     icon: Icon(Icons.ac_unit, size: 25,),
              //     // iconSize: 10,
              //     onPressed: () {

              //     },
              //   ),
              
            ),
          ),
        )
        
      )
    );
  }

  
}

