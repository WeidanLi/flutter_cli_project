import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_cli_project/infrastructure/base_model/PbResultDto.pb.dart';
import 'package:flutter_cli_project/infrastructure/profiles_loader.dart';
import 'package:flutter_cli_project/mock/mock_holder.dart';
import 'package:protobuf/protobuf.dart' as $pb;

Map<String, dynamic> optHeader = {
  'accept-language': 'zh-cn',
  'Accept': 'application/x-protobuf;charset=UTF-8'
};

var dio = new Dio(BaseOptions(
    connectTimeout: 60000,
    headers: optHeader,
    responseType: ResponseType.bytes,
    contentType: new ContentType("application", "x-protobuf"),
    baseUrl: ProfileKeys.BASE_URL,
    requestEncoder: (r, o) {
      var resp_ = o.data as $pb.GeneratedMessage;
      return resp_.writeToBuffer();
    })
);

class NetToolFactory {
  
  static bool _isInit = false;
  
  static create() {
    if (!_isInit) {
      _isInit = true;
      switch (ProfilesLoader.profileActive()) {
        case 'mock':
          return MockNetTool();
        default:
          return NetTool();
      }
    }
  }
}

abstract class INetTool {

  Future<PbResultDto> post<T extends $pb.GeneratedMessage, P extends $pb.GeneratedMessage>(
      String url, {
        P request,
        Map<String, dynamic> queryParameters
      });

  Future<PbResultDto> get<T extends $pb.GeneratedMessage> (
      String url, {
        Map<String, dynamic> queryParameters
      });

}

class NetTool extends INetTool {

  /// Post请求，通过传递请求体 [request] 远程服务响应
  /// 数据的形式，响应提要求传递一个空的 [resp]
  Future<PbResultDto> post<T extends $pb.GeneratedMessage, P extends $pb.GeneratedMessage>(
      String url, {
        P request,
        Map<String, dynamic> queryParameters
      }) async {
    // 请求远程
    Response response = await dio.post(
        url,
        data: request,
        queryParameters: queryParameters
    );
    // 获取响应体
    var respBody = response.data;
    // 开始反序列化
    PbResultDto resp = PbResultDto();
    resp.mergeFromBuffer(respBody);

    return resp;
  }

  /// GET请求
  Future<PbResultDto> get<T extends $pb.GeneratedMessage> (
      String url, {
        Map<String, dynamic> queryParameters
      }) async {
    Response response = await dio.get(url);
    // 获取响应体
    List<int> respBody = response.data;
    // 开始反序列化
    PbResultDto resp = PbResultDto();
    resp.mergeFromBuffer(respBody);

    return resp;
  }

}

class MockNetTool extends INetTool {

  MockNetTool() {
    MockData.initRouter();
  }

  @override
  Future<PbResultDto> get<T extends $pb.GeneratedMessage>(
      String url,
      {Map<String, dynamic> queryParameters}) {
    return MockData.fetch(url, 'get');
  }

  @override
  Future<PbResultDto> post<T extends $pb.GeneratedMessage, P extends $pb.GeneratedMessage>(
      String url,
      {
        P request,
        Map<String, dynamic> queryParameters
      }) {
    return MockData.fetch(url, 'post', body: request, uriParam: queryParameters);
  }
  
}
