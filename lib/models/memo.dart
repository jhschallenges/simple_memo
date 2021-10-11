import 'package:flutter/material.dart';

import 'package:simple_memo/configs/configs.dart';

class MemoModel {
  String? _title;
  String? _text;

  DateTime _created;

  Color? _backgroundColor;

  String? get title => _title;
  String? get text => _text;
  DateTime get created => _created;
  Color? get backgroundColor => _backgroundColor;

  String get key => "$_created";

  void update({String? title, String? text, Color? backgroundColor}) {
    if (title != null) _title = title;
    if (text != null) _text = text;
    if (backgroundColor != null) _backgroundColor = backgroundColor;
  }

  MemoModel({String? title, String? text, Color? backgroundColor})
      : this._title = title,
        this._text = text,
        this._created = DateTime.now(),
        this._backgroundColor = backgroundColor ?? defaultMemoBackgroundColor {
    assert(title != null || text != null);
  }

  MemoModel.fromJson(Map<String?, dynamic> json)
      : this._title = json['title'],
        this._text = json['text'],
        this._created = DateTime.fromMicrosecondsSinceEpoch(json['created']!),
        this._backgroundColor = json['backgroundColor'] != null
            ? Color(json['backgroundColor'])
            : defaultMemoBackgroundColor {
    assert(title != null || text != null);
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['title'] = this._title;
    data['text'] = this._text;
    data['created'] = this._created.microsecondsSinceEpoch;
    data['backgroundColor'] = this._backgroundColor?.value;
    return data;
  }
}
