import 'package:flutter_cli_project/infrastructure/net_tool_box.dart';
import 'package:flutter_cli_project/repository/user_repository.dart';

class IocContainer {

  static Map<String, dynamic> _beanMap = {
    'userRepository': UserRepository(),
    'INetTool': null,
    '_instance': IocContainer()
  };

  static dynamic getBean(String beanName) {
    var bean = _beanMap[beanName];
    if (bean == null) {
      _beanMap[beanName] = _initBean(beanName);
      bean = _beanMap[beanName];
      if (bean == null) {
        throw ArgumentError('bean not found!');
      }
    }

    return bean;
  }

  UserRepository get userRepository {
    return getBean('userRepository');
  }

  INetTool get netTool {
    return getBean('INetTool');
  }

  static instance() {
    return getBean('_instance');
  }

  static dynamic _initBean(String beanName) {
    switch (beanName) {
      case 'INetTool':
        return NetToolFactory.create();
      default:
        return null;
    }

  }

}