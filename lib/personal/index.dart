import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';
import 'package:flutter_cli_project/infrastructure/toast_tool.dart';
import 'package:flutter_cli_project/login/login_page.dart';
import 'package:flutter_cli_project/main_app/authenticate_bloc.dart';
import 'package:flutter_cli_project/personal/dashboard_page.dart';

class HomePage extends PageStateLess {

  @override
  Widget build0(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return state is AuthenticationAuthenticated ?
          _dashboardPage() : LoginPage();
        }
    );
  }

  _dashboardPage() {
    return _PopContainer();
  }

}

class _PopContainer extends PageStateFul {

  @override
  State<StatefulWidget> createState0() {
    return _PopContainerState();
  }

}

class _PopContainerState extends State<_PopContainer> {

  DateTime _lastBackDateTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_lastBackDateTime == null ||
              DateTime.now().difference(_lastBackDateTime) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastBackDateTime = DateTime.now();

            ToastTool.shortOfKey('global.press.back.again');
            return false;
          }
          return true;
        },
        child: DashboardPage()
    );
  }

}

