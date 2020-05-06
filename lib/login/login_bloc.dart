import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cli_project/infrastructure/ioc_container.dart';
import 'package:flutter_cli_project/main_app/authenticate_bloc.dart';
import 'package:flutter_cli_project/repository/user_repository.dart';

import 'dto/UserAuthenticateDto.pb.dart';

/// 登录状态
@immutable
abstract class LoginState extends Equatable {

  const LoginState();

  @override
  List<Object> get props => [];

}

/// 登录初始化状态
class LoginInitial extends LoginState {}

/// 正在登录中状态
class LoginLoading extends LoginState {}

/// 登录失败状态
class LoginFailure extends LoginState {

  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => "LoginFailure { error: $error }";

}

/// 登录事件
@immutable
abstract class LoginEvent extends Equatable{}

/// 登录事件
class LoginButtonPressed extends LoginEvent {
  /// 用户名
  final String username;
  /// 密码
  final String password;

  LoginButtonPressed({
    @required this.username,
    @required this.password
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => "LoginPressed { username: $username, password: $password }";

}

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  AuthenticationBloc authenticationBloc;

  LoginBloc({this.authenticationBloc});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        UserRepository userRepository = IocContainer.getBean('userRepository');
        UserAuthenticateRespDto r = await userRepository.authenticate(username: event.username, password: event.password);
        authenticationBloc.add(LoginIn(token: r.token, opCodes: r.resourceCodes));
        yield LoginInitial();
      } catch (e) {
        print(e);
        yield LoginFailure(error: e.toString());
      }
    }
  }

}