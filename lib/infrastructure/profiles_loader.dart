import 'dart:convert';

import 'package:flutter/material.dart';

import 'context_util.dart';

/// 配置文件的读取器
class ProfilesLoader {

  static Map<String, String> _profileMap = {};
  static bool _isInit = false;

  static initProfile() async {
    if (!_isInit) {
      String profileJson = await DefaultAssetBundle
          .of(CurrentPageContext.get())
          .loadString('assets/profile-config.json');
      Map<String, dynamic> allProfile = JsonDecoder().convert(profileJson);

      _profileMap = Map<String, String>();
      final String profileActive = allProfile['profile.active'];

      allProfile.forEach((key, value) {
        if (key == 'profile.active') {
          _profileMap['profile'] = value;
          return;
        }
        if (!key.contains(profileActive)) {
          return;
        }
        String pKey = key.substring(0, key.indexOf('.' + profileActive));
        _profileMap[pKey] = value;
      });
      _isInit = true;
    }
  }

  static profileActive() {
    return keyOf('profile');
  }

  static keyOf(String profileKey) {
    String value;
    do {
      if (_isInit) {
        value = _profileMap[profileKey];
      }
    } while(!_isInit);

    return value;
  }

}

class ProfileKeys {
  static const BASE_URL = 'baseURL';
}