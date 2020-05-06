import 'dart:math';

import 'package:flutter_cli_project/infrastructure/base_model/PbResultDto.pb.dart';
import 'package:protobuf/protobuf.dart' as $pb;

import './mock_data/mock_data.dart' deferred as data;

class MockData {

  static Map<String, Map<String, Function>> uriRouter;
  static final Error NOT_FOUND_ERR = ArgumentError('resolve function not found!');

  /// 只需要关注数据处理器即可
  static initRouter() async {
    // 惰性加载
    await data.loadLibrary();
    uriRouter = Map<String, Map<String, Function>>();
    // Mock测试用例使用的数据
    _register('/v1/user/login', 'POST', data.testMock);
    _register('/v1/user/login?a=1', 'POST', data.testMock);
    _register(
        '/v1/user/login?a=1', 'POST', data.testMock, routeParam: {'b': '2'});
    _register('/v1/authenticate/login', 'POST', data.userAuthenticate);
  }

  static _register(
      String uri, 
      String method, 
      Function mockFunction, 
      {
        Map<String, String> routeParam
      }) {

    String uriInfo = method.toUpperCase() + ' ' + uri;
    uriRouter[uriInfo] = Map<String, Function>();
    Map<String, String> p = Map<String, String>();
    if (routeParam != null) {
      routeParam.forEach((k, v) {
        p[k] = v;
      });
    }
    if (uriInfo.contains('?')) {
      String uriParam = uriInfo.substring(uriInfo.indexOf('?') + 1);
      uriInfo = uriInfo.substring(0, uriInfo.indexOf('?'));
      for (var keyValue in uriParam.split('&')) {
        var value = keyValue.split('=');
        p[value[0]] = value[1];
      }
    }
    if (p.isEmpty) {
      p['-'] = '-';
    }

    var keySort = p.keys.toList();
    keySort.sort();
    String paramString = '';
    for (var o in keySort) {
      final String val = p[o];
      if (paramString != '') {
        paramString += '&';
      }
      paramString += (o + '=' + val);
    }

    uriRouter[uriInfo][paramString] = mockFunction;
  }

  static Future<PbResultDto> fetch<P extends $pb.GeneratedMessage>(String uri,
      String method, {
        P body,
        Map<String, dynamic> uriParam
      }) async {
    await Future.delayed(Duration(seconds: _randomSecond()));

    // 拿到URI对应的参数以及处理器
    String uriInfo = method.toUpperCase() + ' ' + uri;
    // 解析上面的参数，拿到参数Map
    Map<String, String> p = Map<String, String>();
    if (uriInfo.contains('?')) {
      String uriParam = uriInfo.substring(uriInfo.indexOf('?') + 1);
      uriInfo = uriInfo.substring(0, uriInfo.indexOf('?'));
      for (var keyValue in uriParam.split('&')) {
        var value = keyValue.split('=');
        p[value[0]] = value[1];
      }
    }
    // 如果传递的参数Map不为空，继续插入上面的参数Map
    if (null != uriParam) {
      uriParam.forEach((key, value) {
        p[key] = value.toString();
      });
    }

    var uriParamFunction = uriRouter[uriInfo];
    if (p.isEmpty) {
      var function = uriParamFunction['-=-'];
      if (function == null) {
        throw NOT_FOUND_ERR;
      }
      return function(body: body, param: p);
    }

    // 注册的时候必要的参数Map
    var keySort = p.keys.toList();
    keySort.sort();
    String _findParamString = '';
    for (var o in keySort) {
      final String val = p[o];
      if (_findParamString != '') {
        _findParamString += '&';
      }
      _findParamString += (o + '=' + val);
    }

    if (null == _findParamString || null == uriParamFunction[_findParamString]) {
      throw NOT_FOUND_ERR;
    }
    return uriParamFunction[_findParamString](body: body, param: p);
  }

  static _randomSecond() {
    var waitSeconds = [1, 2, 3, 4, 5];
    return waitSeconds[Random().nextInt(waitSeconds.length)];
  }

}