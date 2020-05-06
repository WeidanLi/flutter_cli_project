import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cli_project/components/common_scaffold.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';
import 'package:flutter_cli_project/infrastructure/i18n_box.dart';

import 'check_bill_routers.dart';

class CheckBillIndex extends Page {

  CheckBillIndex() : super(CheckBillIndexConst.checkBillIndexPath);

  @override
  Widget build0(BuildContext context) {
    return CommonScaffold(
      title: I18nBox.getTextOfContext('index.check.bill.check.pageTitle'),
      showBackBtn: true,
      body: Center(
        child: Text('我的盘点单页'),
      ),
    );
  }

}