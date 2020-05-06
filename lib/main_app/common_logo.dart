import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';

class CommonLogo extends PageStateLess {
  @override
  Widget build0(BuildContext context) {
    return SizedBox(
      width: 140.0,
      child: Image.asset('assets/imgs/logo.jpeg'),
    );
  }

}