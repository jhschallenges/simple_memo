import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';

import 'package:simple_memo/configs/size_config.dart';

import 'package:simple_memo/blocs/memoCtrl.dart';

import 'package:simple_memo/models/memo.dart';

class MemoDetail extends StatelessWidget {
  final MemoController _memoController = Get.find();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  final MemoModel originMemo;

  MemoDetail(this.originMemo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _titleController.text = "${originMemo.title}";
    _textController.text = "${originMemo.text}";

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: SizeConfig.defaultSize * 2.7),
            icon: Icon(Icons.save_outlined, size: SizeConfig.defaultSize * 3.3),
            onPressed: () {
              if (_titleController.text != "" || _textController.text != "") {
                originMemo.update(
                  title: _titleController.text,
                  text: _textController.text,
                );

                _memoController.updateMemo(originMemo);
              }
            },
          )
        ],
      ),
      body: Container(
          color: Colors.yellow.shade100,
          height: SizeConfig.screenHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // title
              Container(
                height: SizeConfig.defaultSize * 6,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 2),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: "Title"),
                  style: TextStyle(fontSize: SizeConfig.defaultSize * 3),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(
                    top: SizeConfig.defaultSize,
                    right: SizeConfig.defaultSize * 2),
                child: Text(
                    "${DateFormat('yyyy-MM-dd.  kk:mm').format(originMemo.created)}"),
              ),
              Expanded(
                  child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    hintText: "Type anything",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(SizeConfig.defaultSize * 2)),
                maxLines: null,
              )),
            ],
          )),
    );
  }
}
