import 'package:flutter/material.dart';
import 'package:flutter_cli_project/components/common_scaffold.dart';
import 'package:flutter_cli_project/components/profile_tile.dart';

class NotFoundPage extends StatelessWidget {
  final appTitle;
  final title;
  final message;
  final IconData icon;
  final String image;
  final iconColor;

  NotFoundPage(
      {this.appTitle = "无人区",
      this.title = "走丢啦~~~",
      this.message = "页面没有找到，可能是迷路了",
      this.icon = Icons.map,
      this.image,
      this.iconColor = Colors.black});

  Widget bodyData() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 100.0,
              color: iconColor,
            ),
            SizedBox(
              height: 20.0,
            ),
            ProfileTile(
              title: title,
              subtitle: message,
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: bodyData(),
      showDrawer: false,
      title: appTitle,
    );
  }
}
