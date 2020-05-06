import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';
import 'package:flutter_cli_project/main_app/system_bloc.dart';

class ToastTool {

  static short(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3
    );
  }

  static shortOfKey(String key) {
    var systemBloc = BlocProvider.of<SystemBloc>(CurrentPageContext.get());
    var text = systemBloc.state.i18nBox.getText(key);
    ToastTool.short(text);
  }

}