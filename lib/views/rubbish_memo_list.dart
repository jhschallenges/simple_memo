import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simple_memo/configs/size_config.dart';

import 'package:simple_memo/blocs/memoCtrl.dart';

import 'package:simple_memo/models/memo.dart';

import 'package:simple_memo/widgets/dialog/warning.dart';

class RubbishMemoList extends StatelessWidget {
  final MemoController _memoController = Get.find();

  RubbishMemoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Rubbish Bin"),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: SizeConfig.defaultSize * 2.7),
              icon: Icon(
                Icons.delete_forever,
                size: SizeConfig.defaultSize * 3.3,
              ),
              onPressed: () {
                Get.dialog(ClearRubbishBinWarning());
              })
        ],
      ),
      body: Container(
        child: GetBuilder<MemoController>(
          builder: (_) {
            return ListView.builder(
                itemBuilder: _dismissibleItemBuilder,
                itemCount: _memoController.rubbishMemoLenght);
          },
        ),
      ),
    );
  }

  Dismissible _dismissibleItemBuilder(BuildContext context, int index) {
    MemoModel _memo = _memoController.rubbishMemoAt(index);
    final _key = Key("${_memo.created}");

    return Dismissible(
      key: _key,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          _memoController.removeMemoInRubbishBinAt(index);
        } else {
          _memoController.restoreMemoInRubbishBinAt(index);
        }
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: SizeConfig.defaultSize),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete_forever,
          size: SizeConfig.defaultSize * 4,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        padding: EdgeInsets.only(right: SizeConfig.defaultSize),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.restore,
          size: SizeConfig.defaultSize * 4,
        ),
      ),
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.symmetric(
          vertical: SizeConfig.defaultSize * 0.5,
          horizontal: SizeConfig.defaultSize * 2,
        ),
        padding: EdgeInsets.all(SizeConfig.defaultSize),
        decoration: BoxDecoration(
          color: _memo.backgroundColor,
          borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 3),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: [
            Text(
              "${_memo.title}",
              style: TextStyle(fontSize: SizeConfig.defaultSize * 3),
            ),
            Text(
              "${_memo.text}",
              style: TextStyle(fontSize: SizeConfig.defaultSize * 2),
            ),
          ],
        ),
      ),
    );
  }
}
