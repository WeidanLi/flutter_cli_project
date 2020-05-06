import 'package:flutter/material.dart';

import 'context_util.dart';

typedef OkCallBack = void Function();

/// 弹窗工具类
class DialogUtil {

  /// 一个简单的弹窗，一般用于完成一个命令请求后提示成功的行为.
  static simpleDialog(String title, String content, {
    BuildContext context
  }) {
    BuildContext _context = context ?? CurrentPageContext.get();
    showDialog(
        context: _context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]
        )
    );
  }

  /// 确认弹窗，一般用于点击一个命令按钮之前的提示是否确认执行的行为.
  static confirmDialog(
      String title,
      String content,
      OkCallBack okCallBack, {
        BuildContext context
      }) {
    BuildContext _context = context ?? CurrentPageContext.get();
    showDialog(
        context: _context,
        builder: (context) =>
            AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      okCallBack();
                    },
                  ),
                  FlatButton(
                    child: Text('取消'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]
            )
    );
  }

}