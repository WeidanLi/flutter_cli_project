import 'package:flutter/material.dart';
import 'package:flutter_cli_project/components/common_scaffold.dart';
import 'package:flutter_cli_project/infrastructure/context_util.dart';
import 'package:flutter_cli_project/infrastructure/i18n_box.dart';

import 'deliver_bill_routers.dart';

class LoadingIndex extends Page {

  LoadingIndex() : super(DeliverBillPickIndexConst.loadingIndexPath);

  @override
  Widget build0(BuildContext context) {
    return CommonScaffold(
      title: I18nBox.getTextOfContext('index.deliver.bill.audit.pageTitle'),
      showBackBtn: true,
      body: Center(
        child: Text('我的审核任务'),
      ),
    );
  }

}