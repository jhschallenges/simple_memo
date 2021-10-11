import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simple_memo/configs/size_config.dart';

import 'package:simple_memo/blocs/memoCtrl.dart';

class ClearRubbishBinWarning extends StatelessWidget {
  final MemoController _memoController = Get.find();

  ClearRubbishBinWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          padding: EdgeInsets.all(SizeConfig.defaultSize * 3),
          child: Text(
            "Are you sure to clear all?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.defaultSize * 2.1,
              fontWeight: FontWeight.bold,
            ),
          )),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.defaultSize * 2,
                  horizontal: SizeConfig.defaultSize),
              child: ElevatedButton(
                  onPressed: () {
                    _memoController.clearRubbishBin();
                    Get.back();
                  },
                  child: Text("Yes"))),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.defaultSize * 2,
                  horizontal: SizeConfig.defaultSize),
              child: ElevatedButton(
                  onPressed: () => Get.back(), child: Text("No")))
        ],
      )
    ]));
  }
}
