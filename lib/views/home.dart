import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simple_memo/configs/size_config.dart';

import 'package:simple_memo/views/memo_list.dart';

import 'package:simple_memo/widgets/bottom_sheet/memo.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(title: Text("Simple Memo")),
      body: MemoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          memoBottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
