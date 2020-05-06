import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';
import 'package:flutter_cli_project/infrastructure/profiles_loader.dart';
import 'package:flutter_cli_project/login/login_bloc.dart';
import 'package:flutter_cli_project/main_app/authenticate_bloc.dart';
import 'package:flutter_cli_project/main_app/common_logo.dart';
import 'package:flutter_cli_project/main_app/system_bloc.dart';

class LoginPage extends PageStateFul {

  @override
  State<StatefulWidget> createState0() {
    return _LoginState();
  }

}

class _LoginState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return build0(context);
  }

  final TextEditingController _unameController = new TextEditingController();
  final TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  
  Widget build0(BuildContext context) {
    return BlocBuilder<SystemBloc, SystemState>(
      builder: (_, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: loginBody(_),
          ),
        );
      },
    );
  }

  loginBody(BuildContext context) => SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(context), loginFields(context)],
        ),
      )
  );

  loginHeader(BuildContext context) {
    var systemState = context.bloc<SystemBloc>().state;
    String loginTitle = systemState.i18nBox.getText('login.title');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonLogo(),
        Text(
          loginTitle,
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  loginFields(BuildContext context) {
    var systemState = context.bloc<SystemBloc>().state;
    var authenticationBloc = context.bloc<AuthenticationBloc>();
    String uNameTitle = systemState.i18nBox.getText('login.input.title');
    String pwdTitle = systemState.i18nBox.getText('login.input.password');
    String loginBtnTitle = systemState.i18nBox.getText('login.btn.login');
    String nameEmptyMsg = systemState.i18nBox.getText('login.input.notempty.title');
    String passwordEmptyMsg = systemState.i18nBox.getText('login.input.notempty.password');
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(authenticationBloc: authenticationBloc),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextFormField(
                  controller: _unameController,
                  decoration: InputDecoration(
                    labelText: uNameTitle,
                    hintText: uNameTitle,
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) {
                    return v.isNotEmpty ? null : nameEmptyMsg;
                  }
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: pwdTitle,
                  labelText: pwdTitle,
                  prefixIcon: Icon(Icons.lock),
                ),
                controller: _pwdController,
                validator: (v) {
                  return v.isNotEmpty ? null : passwordEmptyMsg;
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return state is LoginLoading ? _loginingProgress():Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 30.0),
                  width: double.infinity,
                  child: _loginButton(loginBtnTitle, context)
                );
              },
            ),

          ],
        ),
      ),
    );
  }

  CircularProgressIndicator _loginingProgress() {
    return CircularProgressIndicator(
      backgroundColor: Colors.grey[200],
      valueColor: AlwaysStoppedAnimation(Colors.blue),
    );
  }

  RaisedButton _loginButton(String loginBtnTitle, BuildContext context) {
    return RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  loginBtnTitle,
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  _onLoginBtnClick(context);
                },
              );
  }

  _onLoginBtnClick(BuildContext context) {
    var currentState = _formKey.currentState as FormState;
    var loginBloc = BlocProvider.of<LoginBloc>(context);
    print(ProfilesLoader.keyOf('baseURL'));

    if (currentState.validate()) {
      loginBloc.add(
          LoginButtonPressed(
              username: _unameController.text,
              password: _pwdController.text
          )
      );
    }
  }

}
