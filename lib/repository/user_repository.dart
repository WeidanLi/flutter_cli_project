
import 'package:flutter/material.dart';
import 'package:flutter_cli_project/infrastructure/ioc_container.dart';
import 'package:flutter_cli_project/infrastructure/net_tool_box.dart';
import 'package:flutter_cli_project/login/dto/UserAuthenticateDto.pb.dart';

/// 用户数据仓库
class UserRepository {

  /// 认证
  /// @param username 用户名
  /// @param password 密码
  /// @return 返回认证信息
  Future<UserAuthenticateRespDto> authenticate({
    @required String username,
    @required String password,
  }) async {
    INetTool netTool = IocContainer.instance().netTool;
    var req = UserAuthenticateReqDto();
    req.userName = username;
    req.password = password;
    var pbResult = await netTool.post('/v1/authenticate/login', request: req);
    var userAuthenticateRespDto = pbResult.data.unpackInto(UserAuthenticateRespDto());
    return userAuthenticateRespDto;
  }

  /// 删除Token
  Future<void> deleteToToken() async {
    await Future.delayed(Duration(seconds: 1));
    return ;
  }

  /// 保存Token
  /// @param token 令牌
  Future<void> persistToken(String token) async {
    // 保存
    await Future.delayed(Duration(seconds: 1));
    return ;
  }

  /// 判断是否有Token
  /// @return true: 有; false: 没有Token
  Future<bool> hasToken() async {
    // 读取Token
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

}