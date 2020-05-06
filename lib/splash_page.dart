import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';

import 'main_app/common_logo.dart';

class SplashPage extends PageStateFul {
  @override
  State<StatefulWidget> createState0() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/main", (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: CommonLogo()
        )
    );
  }
}
