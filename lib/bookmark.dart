import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bookmark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
                child: Text(
                  '今まで投稿されたものは二度と復元することはできません。\nもし削除されるにしてもその前に別の場所に保存しておいてください。それは過去のあなたの支えになったはずの言葉だから。',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    height: 2.25,
                  ),
                  textAlign: TextAlign.center,
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10, bottom: 10),
                child: Text(
                  'ビジネス | ジェフベゾス',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 2.75,
                  ),
                  textAlign: TextAlign.center,
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
              ),
              Divider(color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}
