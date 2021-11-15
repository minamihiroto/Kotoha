import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';

class Change extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0.85),
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
