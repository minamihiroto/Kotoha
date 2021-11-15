import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Adsense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("広告が表示される理由"),
        backgroundColor: Colors.blue.withOpacity(0),
      ),
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0.85),
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
