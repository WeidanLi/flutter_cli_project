import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cli_project/infrastructure/i18n_box.dart';
import 'package:flutter_cli_project/personal/themes.dart';

class SystemState{

  ThemeData theme;
  I18nBox i18nBox;

  SystemState(this.theme, this.i18nBox);

}

enum SystemAction { toggle_lang, toggle_theme }

class SystemEvent {

  SystemAction _action;
  dynamic _data;

  SystemEvent(this._action, this._data);

  dynamic get data => _data;

  SystemAction get action => _action;

}

class SystemBloc extends Bloc<SystemEvent, SystemState> {

  @override
  SystemState get initialState => SystemState(Themes.blackTheme, I18nBox.emptyInstance());

  @override
  Stream<SystemState> mapEventToState(SystemEvent event) async* {
    switch (event.action) {
      case SystemAction.toggle_lang:
        final _i18nBox = event.data as I18nBox;
        final _theme = state.theme;
        yield SystemState(_theme, _i18nBox);
        break;
      case SystemAction.toggle_theme:
        final _theme = event.data as ThemeData;
        final _i18nBox = state.i18nBox;
        yield SystemState(_theme, _i18nBox);
        break;
    }
  }


}

