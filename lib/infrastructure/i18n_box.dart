import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cli_project/main_app/system_bloc.dart';

import 'context_util.dart';
import 'local_data_cache.dart';

/// 一个获取i18n配置语言的工具类
class I18nBox {

  Map<String, dynamic> _lang;
  static I18nBox instance;
  List<String> _supportLang = ['en-US', 'zh-CN'];

  I18nBox(this._lang);

  static emptyInstance() {
    return I18nBox({});
  }

  static getInstance() async {
    var localDataCache = await LocalDataCache.getInstance();
    String value = localDataCache.get(SystemCacheKey.LANG_KEY);
    if (value == null || value == '') {
      value = 'zh-CN';
      localDataCache.putString(SystemCacheKey.LANG_KEY, value);
    }

    if (I18nBox.instance == null) {
      String langJSON = await DefaultAssetBundle.of(CurrentPageContext.get()).loadString('assets/lang/lang_$value.json');
      Map<String, dynamic> lang = JsonDecoder().convert(langJSON);
      I18nBox.instance = I18nBox(lang);
    }
    return I18nBox.instance;
  }

  static getTextOfContext(String key) {
    var systemBloc = BlocProvider.of<SystemBloc>(CurrentPageContext.get());
    return systemBloc.state.i18nBox.getText(key);
  }

  void switchLang(String langName) async {
    if (langName == null || langName == '') {
      return;
    }
    I18nBox ins = await I18nBox.getInstance();
    try {
      String langJSON = await DefaultAssetBundle
              .of(CurrentPageContext.get())
              .loadString('assets/lang/lang_$langName.json');
      Map<String, dynamic> lang = JsonDecoder().convert(langJSON);
      ins._lang = lang;

      var localDataCache = await LocalDataCache.getInstance();
      localDataCache.putString(SystemCacheKey.LANG_KEY, langName);
    } catch (e) {
      print(e);

    }
  }

  /// 按顺序切换语言
  Future<void> switchLangList() async {
    var localDataCache = await LocalDataCache.getInstance();
    String value = localDataCache.get(SystemCacheKey.LANG_KEY);
    String nextLang = '';
    if (_supportLang.indexOf(value) ==(_supportLang.length - 1)) {
      nextLang = _supportLang[0];
    } else {
      nextLang = _supportLang[_supportLang.indexOf(value) + 1];
    }
    localDataCache.putString(SystemCacheKey.LANG_KEY, nextLang);

    switchLang(nextLang);
  }

  String getText(String key) {
    if (this._lang == null) {
      return '';
    }
    var text = this._lang[key];
    return text == null ? '' : text.toString();
  }

}
