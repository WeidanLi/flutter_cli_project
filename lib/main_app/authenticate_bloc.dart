import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cli_project/repository/user_repository.dart';

/// 认证状态
abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

/// - uninitialized - 身份验证未初始化
class AuthenticationUninitialized extends AuthenticationState {}
/// - loading - 等待保存/删除Token
class AuthenticationLoading extends AuthenticationState {}
/// - authenticated - 认证成功
class AuthenticationAuthenticated extends AuthenticationState {

  String _token;
  List<String> _resourceCodes;

  AuthenticationAuthenticated(this._token, this._resourceCodes):
        assert(_token != null),assert(_resourceCodes != null);

  @override
  List<Object> get props => [_token, _resourceCodes];

  List<String> get resourceCodes => _resourceCodes;

  String get token => _token;

  String userName() {
    /// TODO
    return '张三';
  }


}
/// - unauthenticated - 未认证
class AuthenticationUnauthenticated extends AuthenticationState {}

/// 认证事件
abstract class AuthenticationEvent extends Equatable {

  const AuthenticationEvent();

  @override
  List<Object> get props => [];

}

/// APP 启动事件
class AppStart extends AuthenticationEvent {}

/// APP 登录事件
class LoginIn extends AuthenticationEvent {

  final String token;
  final List<String> opCodes;

  LoginIn({this.token, this.opCodes});

  @override
  List<Object> get props => [token, opCodes];

}

/// APP 退出登录事件
class LoginOut extends AuthenticationEvent {}

/// 认证Bloc
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  // 用户仓库
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository}): assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStart) {
      // 判断是否有Token
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        yield AuthenticationAuthenticated('', []);
      } else {
        yield AuthenticationUnauthenticated();
      }
    } else if (event is LoginIn) {
      yield AuthenticationLoading();
      yield AuthenticationAuthenticated(event.token, event.opCodes);
    } else if (event is LoginOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
