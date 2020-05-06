import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cli_project/infrastructure/i18n_box.dart';
import 'package:flutter_cli_project/infrastructure/profiles_loader.dart';
import 'package:flutter_cli_project/main_app/routes.dart';
import 'package:flutter_cli_project/repository/user_repository.dart';

import 'infrastructure/context_util.dart';
import 'infrastructure/ioc_container.dart';
import 'main_app/authenticate_bloc.dart';
import 'main_app/system_bloc.dart';
import 'splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends PageStateLess {

  Future<void> setupGlobalBloc(BuildContext context) async {
    try {
      // 初始化i18n
      final I18nBox i18nBox = await I18nBox.getInstance();
      var systemBloc = context.bloc<SystemBloc>();
      systemBloc.add(SystemEvent(SystemAction.toggle_lang, i18nBox));
      // 初始化 profile_loader
      ProfilesLoader.initProfile();
    } catch (e) {
    }
  }

  @override
  Widget build0(BuildContext context) {
    UserRepository userRepository = IocContainer.instance().userRepository;

    return MultiBlocProvider(
      providers: [
        BlocProvider<SystemBloc>(
          create: (BuildContext context) => SystemBloc(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(
            userRepository: userRepository
          ),
        ),
      ],
      child: BlocBuilder<SystemBloc, SystemState>(
        builder: (_, state) {
          setupGlobalBloc(_);
          return MaterialApp(
            theme: state.theme,
            home: SplashPage(),
            onGenerateRoute: (RouteSettings settings) {
              return Routes.routeGenerator(settings, _);
            },
          );
        },
      )
    );
  }

}
