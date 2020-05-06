import 'package:flutter/widgets.dart';

class CurrentPageContext {
  
  static BuildContext context;
  
  static void set(BuildContext context) {
    CurrentPageContext.context = context;
  }
  
  static BuildContext get() {
    return CurrentPageContext.context;
  }
  
}

/// 用于有状态的页面的Context父类，可以用于记录当前的BuildContext
abstract class PageStateFul extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    State<StatefulWidget> state = createState0();
    CurrentPageContext.set(state.context);
    return state;
  }

  State<StatefulWidget> createState0();

}

abstract class PageStateLess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CurrentPageContext.set(context);
    var widget = build0(context);
    return widget;
  }

  Widget build0(BuildContext context);

}

abstract class Page extends PageStateLess {

  final String routerPath;

  Page(this.routerPath);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: routerPath,
      child: super.build(context),
    );
  }

  Widget build0(BuildContext context);

}