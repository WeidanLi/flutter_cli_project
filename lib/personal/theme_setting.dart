import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cli_project/components/common_scaffold.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';
import 'package:flutter_cli_project/main_app/system_bloc.dart';
import 'package:flutter_cli_project/personal/themes.dart';

class ThemeSetting extends PageStateLess {

  @override
  Widget build0(BuildContext context) {
    return BlocBuilder<SystemBloc, SystemState>(
      builder: (_, state) {
        return CommonScaffold(
          body: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "暗夜黑（推荐）",
                    style: TextStyle(
                        fontWeight: FontWeight.w100, fontSize: 18.0),
                  ),
                  leading: Icon(
                    Icons.bookmark,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    _switchTheme(context, Themes.blackTheme);
                  },
                ),
                ListTile(
                  title: Text(
                    "骚气白",
                    style: TextStyle(
                        fontWeight: FontWeight.w100, fontSize: 18.0),
                  ),
                  leading: Icon(
                    Icons.collections,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    _switchTheme(context, Themes.kIOSTheme);
                  },
                ),
              ]
          ),
        );
      },
    );
  }

  void _switchTheme(BuildContext context, ThemeData themeData) {
    var systemBloc = context.bloc<SystemBloc>();
    systemBloc.add(SystemEvent(SystemAction.toggle_theme, themeData));
  }

}