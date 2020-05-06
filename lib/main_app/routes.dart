import 'package:flutter/material.dart';
import 'package:flutter_cli_project/personal/index.dart';
import 'package:flutter_cli_project/personal/theme_setting.dart';
import 'package:flutter_cli_project/services/check_bill/check_bill_index.dart';
import 'package:flutter_cli_project/services/check_bill/check_bill_routers.dart';
import 'package:flutter_cli_project/services/deliver_bill_pick/deliver_bill_routers.dart';
import 'package:flutter_cli_project/services/deliver_bill_pick/loading_index.dart';
import 'package:flutter_cli_project/services/deliver_bill_pick/pick_index.dart';

import 'notfound_page.dart';

class Routes {

  /// 路由信息
  static final Map<String, WidgetBuilder> _routes = {
    '/themeSetting': (BuildContext context) => ThemeSetting(),
    '/main': (BuildContext context) => HomePage(),
    DeliverBillPickIndexConst.pickIndexPath: (BuildContext context) => PickIndex(),
    DeliverBillPickIndexConst.loadingIndexPath: (BuildContext context) => LoadingIndex(),
  DeliverBillPickIndexConst.auditIndexPath: (BuildContext context) => CheckBillIndex(),
    CheckBillIndexConst.checkBillIndexPath: (BuildContext context) => CheckBillIndex(),
  };

  /// 路由拦截
  static Route routeGenerator(RouteSettings settings, BuildContext buildContext) {
    final String name = settings.name;
    final Function pageBuilder = _routes[name];
    if (pageBuilder != null) {
      if (settings.arguments != null) {
        // 如果透传了参数
        return MaterialPageRoute(
            builder: (context) =>
                pageBuilder(context, arguments: settings.arguments));
      } else {
        // 没有透传参数
        return MaterialPageRoute(builder: (context) => pageBuilder(context));
      }
    }
    return MaterialPageRoute(builder: (context) => NotFoundPage());
  }

}