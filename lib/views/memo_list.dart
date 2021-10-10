import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simple_memo/configs/size_config.dart';

import 'package:simple_memo/blocs/memoCtrl.dart';

import 'package:simple_memo/models/memo.dart';

class MemoList extends StatelessWidget {
  final MemoController _memoController = Get.find();

  MemoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<MemoController>(
        builder: (_) {
          return ReorderableListView.builder(
              itemBuilder: _dismissibleItemBuilder,
              itemCount: _memoController.lenght,
              onReorder: _memoController.reorder);
        },
      ),
    );
  }

  Dismissible _dismissibleItemBuilder(BuildContext context, int index) {
    MemoModel _memo = _memoController.memoAt(index);
    final _key = Key("${_memo.created}");

    return Dismissible(
      key: _key,
      onDismissed: (DismissDirection direction) {
        _memoController.removeAt(index);
      },
      child: Container(
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
            Text("${_memo.title}"),
            Text("${_memo.text}"),
          ],
        ),
      ),
    );
  }
}
