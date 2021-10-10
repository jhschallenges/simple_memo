import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simple_memo/widgets/memo.dart';

memoBottomSheet() {
  Get.bottomSheet(MemoWritingWidget(), backgroundColor: Colors.white);
}
