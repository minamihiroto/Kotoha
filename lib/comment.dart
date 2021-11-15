import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0.85),
      appBar: AppBar(
        title: const Text("投稿"),
        backgroundColor: Colors.blue.withOpacity(0),
        actions: [
          TextButton(
            onPressed: () {
              // 投稿処理を書く（空欄の場合発火しない）
            },
            child: Text(
              '完了',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(right: 30, left: 30),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '入力してください（140字以内）',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.white30),
                ),
                textAlign: TextAlign.center,
                maxLines:8,
                maxLength: 140,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
