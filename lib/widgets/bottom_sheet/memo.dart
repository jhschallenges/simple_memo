import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simple_memo/blocs/memoCtrl.dart';

import 'package:simple_memo/configs/size_config.dart';
import 'package:simple_memo/models/memo.dart';

memoBottomSheet() {
  Get.bottomSheet(MemoWritingWidget(), backgroundColor: Colors.white);
}

class MemoWritingWidget extends StatelessWidget {
  final MemoController _memoController = Get.find();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  MemoWritingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.6,
      padding: EdgeInsets.all(SizeConfig.defaultSize * 3),
      child: Column(children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 3),
                border: Border.all(color: Colors.black)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // title
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize * 2),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: "Title"),
                    style: TextStyle(fontSize: SizeConfig.defaultSize * 3),
                  ),
                ),
                // text
                Container(
                    height: SizeConfig.screenHeight * 0.3,
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                          hintText: "Type anything",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.all(SizeConfig.defaultSize * 2)),
                      maxLines: 20,
                    )),
              ],
            )),

        // button
        Container(
            padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
            width: SizeConfig.screenWidth * 0.6,
            height: SizeConfig.defaultSize * 9,
            child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text != "" ||
                      _textController.text != "") {
                    _memoController.addLast(MemoModel(
                      title: _titleController.text,
                      text: _textController.text,
                      // TODO color picker
                    ));
                  }
                  Get.back();
                },
                child: Text(
                  "save",
                  style: TextStyle(fontSize: SizeConfig.defaultSize * 2.3),
                )))
      ]),
    );
  }
}
