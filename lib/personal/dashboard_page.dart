import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cli_project/components/common_scaffold.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';
import 'package:flutter_cli_project/infrastructure/toast_tool.dart';
import 'package:flutter_cli_project/main_app/authenticate_bloc.dart';
import 'package:flutter_cli_project/main_app/system_bloc.dart';
import 'package:flutter_cli_project/services/check_bill/check_bill_routers.dart';
import 'package:flutter_cli_project/services/deliver_bill_pick/deliver_bill_routers.dart';

class DashboardPage extends PageStateLess {

  List<Widget> _menuList(SystemState systemState, AuthenticationAuthenticated state, BuildContext buildContext) {
    List<_MenuBtn> menuBtns = [];
    /// 开始定义面板的功能按钮
    menuBtns.add(_MenuBtn(
        'dashboard.deliver.bill.title', 'dashboard.deliver.bill.pick',
        Icons.add_shopping_cart, 'deliverBillPick', DeliverBillPickIndexConst.pickIndexPath));
    menuBtns.add(_MenuBtn(
        'dashboard.deliver.bill.title', 'dashboard.deliver.bill.deliver',
        Icons.directions_car, 'deliverBillPick', DeliverBillPickIndexConst.loadingIndexPath));
    menuBtns.add(_MenuBtn(
        'dashboard.deliver.bill.title', 'dashboard.deliver.bill.audit',
        Icons.event, 'deliverBillPick', DeliverBillPickIndexConst.auditIndexPath));
    menuBtns.add(_MenuBtn(
        'dashboard.check.bill.title', 'dashboard.check.bill.auditing',
        Icons.assignment, 'deliverBillPick2', CheckBillIndexConst.checkBillIndexPath));
    return _caculateMenuRow(systemState, state, menuBtns, buildContext);
  }

  @override
  Widget build0(BuildContext context) {
    return CommonScaffold(
        body: BlocBuilder<SystemBloc, SystemState> (
          builder: (_, state) {
            var authBloc = BlocProvider.of<AuthenticationBloc>(context);
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: _menuList(state, authBloc.state, _),
                  )
              ),
            );
          },
        )
    );

  }

  /// 根据注册的MenuBtn，结合一级标题和权限代码决定是否给予渲染.
  List<Widget> _caculateMenuRow(SystemState systemState,
      AuthenticationAuthenticated state, List<_MenuBtn> menuBtns, BuildContext buildContext) {
    /// 按一级标题分组
    Map<String, List<_MenuBtn>> first2Btn = LinkedHashMap<String, List<_MenuBtn>>();
    for (var value in menuBtns) {
      var first2btns = first2Btn[value.firstTitle];
      if (null == first2btns) {
        first2Btn[value.firstTitle] = [value];
      } else {
        first2btns.add(value);
      }
    }

    List<Widget> wgts = [];
    var resourceCode = state.resourceCodes;
    for (var entry in first2Btn.entries) {
      List<_MenuBtn> list = List.from(entry.value);
      list.retainWhere((menuBtn) => resourceCode.contains(menuBtn.resourceCode));
      if (list.isEmpty) {
        continue;
      }

      if (wgts.isNotEmpty) {
        wgts.add(SizedBox(height: 10.0));
      }

      wgts.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                systemState.i18nBox.getText(entry.key),
                style:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
          )
      );
      wgts.add(
          SizedBox(
            height: 10.0,
          )
      );

      int prevRow = (0 ~/ 3).toInt();
      List<_MenuBtn> _temp = [];
      for (int i = 0; i < list.length; i++) {
        // 换行，把之前的放进去，然后清空
        if ((i ~/ 3).toInt() != prevRow) {
          _addMenuRow(wgts, systemState, _temp, buildContext);
          prevRow = (i ~/ 3).toInt();
        }

        _temp.add(list[i]);

        if (i == list.length - 1) {
          _addMenuRow(wgts, systemState, _temp, buildContext);
        }
      }
    }
    return wgts;
  }

  void _addMenuRow(List<Widget> wgts, SystemState systemState, List<_MenuBtn> _temp, BuildContext buildContext) {
    wgts.add(
        _DashboardMenuRow(
          firstIcon: _temp.length > 0 ? _temp[0].icon : null,
          firstLabel: _temp.length > 0 ? systemState.i18nBox
              .getText(_temp[0].label) : null,
          firstPath: _temp.length > 0 ? _temp[0].routePath : null,
          secondIcon: _temp.length > 1 ? _temp[1].icon : null,
          secondLabel: _temp.length > 1 ? systemState.i18nBox
              .getText(_temp[1].label) : null,
          secondPath: _temp.length > 1 ? _temp[1].routePath : null,
          thirdIcon: _temp.length > 2 ? _temp[2].icon : null,
          thirdLabel: _temp.length > 2 ? systemState.i18nBox
              .getText(_temp[2].label) : null,
          thirdPath: _temp.length > 2 ? _temp[2].routePath : null,
        )
    );
    _temp.clear();
  }

}

class _MenuBtn {
  /// 一级标题
  final firstTitle;
  final label;
  final IconData icon;
  final resourceCode;
  final routePath;

  _MenuBtn(this.firstTitle, this.label, this.icon, this.resourceCode,
      this.routePath);

}

class _DashboardMenuRow extends PageStateLess {
  final firstLabel;
  final IconData firstIcon;
  final firstPath;
  final secondLabel;
  final IconData secondIcon;
  final secondPath;
  final thirdLabel;
  final IconData thirdIcon;
  final thirdPath;


  _DashboardMenuRow({this.firstLabel, this.firstIcon, this.firstPath,
    this.secondLabel, this.secondIcon, this.secondPath, this.thirdLabel,
    this.thirdIcon, this.thirdPath});

  @override
  Widget build0(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    List<Widget> widgets = [];
    if (firstIcon != null && firstLabel != null) {
      widgets.add(SizedBox.fromSize(
        size: Size.square(deviceSize.width / 3.3),
        child: Hero(
          tag: firstPath,
          child: LabelBelowIcon(
            betweenHeight: 15.0,
            icon: firstIcon,
            label: firstLabel,
            iconColor: Colors.indigo.shade800,
            isCircleEnabled: false,
            onPressed: () {
              _toPage(context, firstPath);
            },
          ),
        )
      ));
    }
    if (secondIcon != null && secondLabel != null) {
      widgets.add(SizedBox.fromSize(
        size: Size.square(deviceSize.width / 3.3),
        child: Hero(
          tag: secondPath,
          child: LabelBelowIcon(
            betweenHeight: 15.0,
            icon: secondIcon,
            label: secondLabel,
            iconColor: Colors.indigo.shade800,
            isCircleEnabled: false,
            onPressed: () {
              _toPage(context, secondPath);
            },
          ),
        )
      ));
    }
    if (thirdIcon != null && thirdLabel != null) {
      widgets.add(SizedBox.fromSize(
        size: Size.square(deviceSize.width / 3.3),
        child: Hero(
          tag: thirdPath,
          child: LabelBelowIcon(
            betweenHeight: 15.0,
            icon: thirdIcon,
            label: thirdLabel,
            iconColor: Colors.indigo.shade800,
            isCircleEnabled: false,
            onPressed: () {
              _toPage(context, thirdPath);
            },
          ),
        )
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }

  void _toPage(BuildContext context, String path) {
    if (path != null && path != '') {
      Navigator.of(context).pushNamed(path);
    } else {
      ToastTool.shortOfKey('common.drawer.nothing');
    }
  }
}

class LabelBelowIcon extends PageStateLess {
  final label;
  final IconData icon;
  final iconColor;
  final onPressed;
  final circleColor;
  final isCircleEnabled;
  final betweenHeight;

  LabelBelowIcon(
      {this.label,
        this.icon,
        this.onPressed,
        this.iconColor = Colors.white,
        this.circleColor,
        this.isCircleEnabled = true,
        this.betweenHeight = 5.0});
  @override
  Widget build0(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              isCircleEnabled
                  ? CircleAvatar(
                backgroundColor: circleColor,
                radius: 20.0,
                child: Icon(
                  icon,
                  size: 12.0,
                  color: iconColor,
                ),
              )
                  : Icon(
                icon,
                size: 23.0,
                color: iconColor,
              ),
              SizedBox(
                height: betweenHeight,
              ),
              Text(
                label,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
