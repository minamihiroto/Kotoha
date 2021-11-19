import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  @override
  CommentState createState() => CommentState();
}

class CommentState extends State<Comment> {
  List<DropdownMenuItem<int>> _items = List();
  int _selectItem = 0;

  @override
  void initState() {
    super.initState();
    setItems();
    _selectItem = _items[0].value;
  }

  void setItems() {
    _items
      ..add(DropdownMenuItem(
        child: Text(
          'ジャンル選択',
          style: TextStyle(fontSize: 16, color: Colors.white54),
        ),
        value: 1,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          'ビジネス',
          style: TextStyle(fontSize: 16),
        ),
        value: 2,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '歌詞',
          style: TextStyle(fontSize: 16),
        ),
        value: 3,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '励まし',
          style: TextStyle(fontSize: 16),
        ),
        value: 4,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0.85),
      appBar: AppBar(
        title: const Text(
          "投稿",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
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
          margin: EdgeInsets.only(
            right: 30,
            left: 30,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '入力してください（140字以内）',
                  counterText: '',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.white54),
                ),
                textAlign: TextAlign.center,
                maxLines: 8,
                maxLength: 140,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '引用元（30字以内）',
                  hintStyle: TextStyle(color: Colors.white54),
                  counterText: '',
                ),
                maxLines: 1,
                maxLength: 30,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.black87,
                  ),
                  child: DropdownButton(
                    style: TextStyle(color: Colors.white),
                    items: _items,
                    value: _selectItem,
                    onChanged: (value) => {
                      setState(() {
                        _selectItem = value;
                      }),
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
