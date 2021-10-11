import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:simple_memo/models/memo.dart';

class MemoController extends GetxController {
  final _box = GetStorage();

  late final List<String> _memoKeyIndexes;
  late final List<String> _rubbishMemoKeyIndexes; // 휴지통

  bool isLoading = true;

  int get lenght => _memoKeyIndexes.length;
  int get rubbishMemoLenght => _rubbishMemoKeyIndexes.length;

  void init() {
    // init _memoKeyIndexes
    _memoKeyIndexes = List<String>.from(_box.read("memoIndexes") ?? []);
    _rubbishMemoKeyIndexes =
        List<String>.from(_box.read("rubbishMemoIndexes") ?? []);

    isLoading = false;
    update();
  }

  MemoModel memoAt(int i) {
    return MemoModel.fromJson(_box.read(_memoKeyIndexes[i]));
  }

  MemoModel rubbishMemoAt(int i) {
    return MemoModel.fromJson(_box.read(_rubbishMemoKeyIndexes[i]));
  }

  void addLast(MemoModel memo) {
    log("${memo.key}");
    _box.write(memo.key, memo.toJson()); // write
    _memoKeyIndexes.add(memo.key); // add key
    _box.write("memoIndexes", _memoKeyIndexes); // save

    update();
  }

  void updateMemo(MemoModel memo) {
    log("${memo.key}");

    _box.write(memo.key, memo.toJson()); // write

    update();
  }

  /// 해당 인덱스의 메모를 휴지통으로
  void moveToRubbishBinAt(int index) {
    // live list
    _rubbishMemoKeyIndexes.add(_memoKeyIndexes[index]);
    _memoKeyIndexes.removeAt(index);

    // save at localstorage
    _box.write("rubbishMemoIndexes", _rubbishMemoKeyIndexes);
    _box.write("memoIndexes", _memoKeyIndexes);

    update();
  }

  void restoreMemoInRubbishBinAt(int index) {
    // live list
    _memoKeyIndexes.add(_rubbishMemoKeyIndexes[index]);
    _rubbishMemoKeyIndexes.removeAt(index);

    // save at localstorage
    _box.write("memoIndexes", _memoKeyIndexes);
    _box.write("rubbishMemoIndexes", _rubbishMemoKeyIndexes);

    update();
  }

  void removeMemoInRubbishBinAt(int index) {
    String _key = _rubbishMemoKeyIndexes[index];

    // live list
    _rubbishMemoKeyIndexes.removeAt(index);

    // save at localstorage
    _box.write("rubbishMemoIndexes", _rubbishMemoKeyIndexes);
    _box.remove(_key);

    update();
  }

  void clearRubbishBin() {
    // save at localstorage
    _box.remove("rubbishMemoIndexes");
    _rubbishMemoKeyIndexes.forEach((_key) => _box.remove(_key));

    // live list
    _rubbishMemoKeyIndexes.clear();

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
