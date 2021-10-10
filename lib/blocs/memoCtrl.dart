import 'dart:developer';

import 'dart:collection';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:simple_memo/models/memo.dart';

class MemoController extends GetxController {
  final _box = GetStorage();

  // final List<MemoModel> _memos = [];
  late final List<String> _memoKeyIndexes;

  bool isLoading = true;

  int get lenght => _memoKeyIndexes.length;
  // UnmodifiableListView<MemoModel> get memos => UnmodifiableListView(_memos);

  void init() {
    // init _memoKeyIndexes
    _memoKeyIndexes = List<String>.from(_box.read("memoIndexes"));

    // // create list
    // for (String i in _memoKeyIndexes) {
    //   _memos.add(MemoModel.fromJson(_box.read(i)));
    // }

    isLoading = false;
    update();
  }

  MemoModel memoAt(int i) {
    return MemoModel.fromJson(_box.read(_memoKeyIndexes[i]));
  }

  void addLast(MemoModel memo) {
    final _key = "${memo.created}";

    // save at localstorage
    _box.write(_key, memo.toJson()); // write
    _memoKeyIndexes.add(_key); // add key
    _box.write("memoIndexes", _memoKeyIndexes); // save

    // live list
    // _memos.add(memo);

    update();
  }

  void removeAt(int index) {
    // live list
    _memoKeyIndexes.removeAt(index);

    // save at localstorage
    _box.write("memoIndexes", _memoKeyIndexes);

    update();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    // live list
    String _tmp = _memoKeyIndexes[oldIndex];
    _memoKeyIndexes.removeAt(oldIndex);
    _memoKeyIndexes.insert(newIndex, _tmp);

    // save at localstorage
    _box.write("memoIndexes", _memoKeyIndexes);

    update();
  }
}
