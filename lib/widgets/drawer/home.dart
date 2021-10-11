import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simple_memo/configs/size_config.dart';

import 'package:simple_memo/views/rubbish_memo_list.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Drawer(
            child: ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 0),
      children: [
        _header(),
        Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: ListTile(
              leading: Icon(Icons.delete, size: 40),
              title: Text(
                "Rubbish Bin",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => Get.to(() => RubbishMemoList()),
            )),
      ],
    )));
  }

  Container _header() {
    return Container(
      height: SizeConfig.defaultSize * 10,
      decoration: BoxDecoration(color: Colors.blue
          // image: DecorationImage(
          //     image: AssetImage("assets/images/header_background.jpg"),
          //     fit: BoxFit.cover),
          ),
    );
  }
}
