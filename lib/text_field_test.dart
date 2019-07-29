import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTest extends StatelessWidget {
  InputTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var result;

    return baseTest3(context);
  }
}

baseTest3(BuildContext context) {
  var show = TextField(
    decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(//获取焦点时边线
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(//可用时边线
          borderSide: BorderSide(color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
      //装饰线
      border: OutlineInputBorder(),
      //四周外框装饰
      labelText: 'username',
      //修饰文字
      labelStyle: TextStyle(color: Colors.deepPurpleAccent),
      //标题文字样式
      helperText: "help me",
      helperStyle: TextStyle(color: Colors.blue),

      suffixText: "suffix",
      suffixIcon: Icon(Icons.done),
      suffixStyle: TextStyle(color: Colors.green),

      counterText: "counter",
      counterStyle: TextStyle(color: Colors.orange),

      prefixText: "ID  ",
      prefixStyle: TextStyle(color: Colors.blue),
      prefixIcon: Icon(Icons.language),

      fillColor: Color(0x110099ee),
      filled: true,

//      errorText: "error",
//      errorMaxLines: 1,
//      errorStyle: TextStyle(color: Colors.red),
//      errorBorder: UnderlineInputBorder(),
      hintText: "请输入用户名",
      //提示文字
      hintMaxLines: 1,
      //提示文字最大行数
      hintStyle: TextStyle(color: Colors.black38),
      //提示文字样式

      icon: Icon(Icons.assignment_ind),
    ),
  );
  return show;
}

baseTest0(BuildContext context) {
  var show = TextField(
    controller: TextEditingController(
        text: ""
            "3.1415926535 8979323846 2643383279 5028841971 6939937510 "
            "5820974944 5923078164 0628620899 8628034825 3421170679 8214808651 3282306647 0938446095 "
            "5058223172 5359408128 4811174502 8410270193 8521105559 6446229489 5493038196 4428810975 6"
            "659334461 2847564823 3786783165 2712019091 4564856692 3460348610 4543266482 1339360726 024"
            "9141273 7245870066 0631558817 4881520920 9628292540 9171536436 7892590360 0113305305 4882046"
            "652 1384146951 9415116094 3305727036 5759591953 0921861173 8193261179 3105118548 0744623799"),
    maxLines: 3,
    //最大行数
    minLines: 2,
    //最小行数
    maxLength: 20,
    //最大字符
    maxLengthEnforced: false,
    //不强制最大字符限制，但飘红
    style: TextStyle(color: Colors.blue, fontSize: 20),
    //文字样式
    obscureText: false,
    //是否是密文 默认false
    textDirection: TextDirection.ltr,
    //文字从左到右排列
    textAlign: TextAlign.center,
    //文字对齐
    enabled: true,
    //是否可用
    readOnly: false,
    //是否只读，不可写
    autofocus: true,
    //自动获取焦点(自动打开软键盘)
    expands: false,
    //输入框自延展，必须maxLines和minLines为null
    decoration: InputDecoration(
      //装饰线
      border: OutlineInputBorder(), //四周外框装饰
      labelText: 'username', //修饰文字
    ),
    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
    //只允许数字
    dragStartBehavior: DragStartBehavior.down,
    scrollController:
        ScrollController(initialScrollOffset: 0, keepScrollOffset: false),
    scrollPadding: EdgeInsets.all(20),
    //滚动区域的内边距
    scrollPhysics: BouncingScrollPhysics(),
    keyboardAppearance: Brightness.light,

    onTap: () {
      //点击事件
      print("onTap");
    },
    onChanged: (str) {
      //文字输入回调
      print("onChanged:$str");
    },
    onEditingComplete: () {
      //完成时回调
      print("onEditingComplete");
      FocusScope.of(context).requestFocus(FocusNode());
    },

    onSubmitted: (str) {
      print("onSubmitted:$str");
    },

    showCursor: true,
    //是否显示游标
    cursorColor: Colors.deepOrange,
    //游标颜色
    cursorRadius: Radius.circular(2),
    //游标圆角
    cursorWidth: 3,
    //游标宽度

    keyboardType: TextInputType.text, //软键盘类型
  );
  return show;
}

baseTest1() {
  var show = TextField(
    obscureText: true, //是否是密文 默认false
    decoration: InputDecoration(
      //输入框装饰
      border: OutlineInputBorder(), //四周外框装饰
      labelText: 'Password', //修饰文字
    ),
  );
  return show;
}

baseTest2() {
  var show = TextField(
    obscureText: false, //是否是密文 默认false
    decoration: InputDecoration(
      //输入框装饰
      border: UnderlineInputBorder(), //底线装饰
      labelText: 'username', //修饰文字
    ),
  );
  return show;
}

//var show = baseTest0();
