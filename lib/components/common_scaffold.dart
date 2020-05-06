import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';
import 'package:flutter_cli_project/infrastructure/toast_tool.dart';
import 'package:flutter_cli_project/main_app/authenticate_bloc.dart';
import 'package:flutter_cli_project/main_app/system_bloc.dart';

class CommonScaffold extends PageStateLess {

  final title;
  final Widget body;
  final bool showDrawer;
  final bool showBackBtn;

  CommonScaffold({
    @required this.body,
    this.title,
    this.showDrawer = true,
    this.showBackBtn = false
  });

  @override
  Widget build0(BuildContext context) {
    return BlocBuilder<SystemBloc, SystemState>(
      builder: (_, state) {
        var title = this.title == null
            ? state.i18nBox.getText('global.title')
            : this.title;
        return Scaffold(
            backgroundColor: state.theme.backgroundColor,
            appBar: AppBar(
              title: Text(title),
              leading: showBackBtn ? IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white), //自定义图标
                onPressed: () {
                  // 打开抽屉菜单
                  Navigator.of(context).pop();
                },
              ) : null,
            ),
            body: this.body,
            drawer: showDrawer ? AppDrawer() : null
        );
      },
    );
  }

}

class AppDrawer extends PageStateLess {

  @override
  Widget build0(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (_, state) {
              final s = state as AuthenticationAuthenticated;
              return UserAccountsDrawerHeader(
                accountName: Text(s.userName()),
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/imgs/logo.jpeg'),
                ),
              );
            },
          ),
          ListTile(
            title: BlocBuilder<SystemBloc, SystemState>(
              builder: (_, state) {
                return Text(
                  state.i18nBox.getText('common.drawer.theme.setting'),
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18.0),
                );
              },
            ),
            leading: Icon(
              Icons.collections,
              color: Colors.blue,
            ),
            onTap: () {
              // 弹出themeSetting的之前的路由信息
              Navigator.of(context).pushNamedAndRemoveUntil('/themeSetting', (Route<dynamic> route) {
                return route.settings.name == '/'||route.settings.name == '/main';
              });
            },
          ),
          ListTile(
            title: BlocBuilder<SystemBloc, SystemState>(
              builder: (_, state) {
                return Text(
                  state.i18nBox.getText('common.drawer.dashboard'),
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18.0),
                );
              },
            ),
            leading: Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
            onTap: () {
              // 路由到面板的时候永远是路由的顶层
              Navigator.of(context).pushNamedAndRemoveUntil("/main", (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: BlocBuilder<SystemBloc, SystemState>(
              builder: (_, state) {
                return Text(
                  state.i18nBox.getText('common.drawer.operator.log'),
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18.0),
                );
              },
            ),
            leading: Icon(
              Icons.timeline,
              color: Colors.cyan,
            ),
            onTap: () {
              ToastTool.shortOfKey('common.drawer.nothing');
            },
          ),
          Divider(),
          ListTile(
            title: BlocBuilder<SystemBloc, SystemState>(
              builder: (_, state) {
                return Text(
                  state.i18nBox.getText('common.drawer.pda.setting'),
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18.0),
                );
              },
            ),
            leading: Icon(
              Icons.settings,
              color: Colors.brown,
            ),
            onTap: () {
              ToastTool.shortOfKey('common.drawer.nothing');
            },
          ),
          Divider(),
          ListTile(
            title: BlocBuilder<SystemBloc, SystemState>(
              builder: (_, state) {
                return Text(
                  state.i18nBox.getText('common.drawer.lang.setting'),
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18.0),
                );
              },
            ),
            leading: Icon(
              Icons.golf_course,
              color: Colors.brown,
            ),
            onTap: () {
              _switchSystemLang(context);
            },
          ),
        ],
      ),
    );
  }

  void _switchSystemLang(BuildContext context) {
    var systemBloc = BlocProvider.of<SystemBloc>(context);
    systemBloc.state.i18nBox.switchLangList();
  }

}