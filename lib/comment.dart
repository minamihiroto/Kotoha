import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

class Comment extends StatefulWidget {
  @override
  CommentState createState() => CommentState();
}

class CommentState extends State<Comment> {
  List<DropdownMenuItem<int>> _items = [];
  int _selectItem = 0;
  String messageText = '';
  String citation = '';

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
          'ジャンル選択(必須)',
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
      backgroundColor: Colors.black.withOpacity(0.85),
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
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                maxLength: 140,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                onChanged: (String value) {
                  setState(
                    () {
                      messageText = value;
                    },
                  );
                },
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
                onChanged: (String value) {
                  setState(
                    () {
                      citation = value;
                    },
                  );
                },
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () async {
              if (messageText != '' && citation != '' && _selectItem != 1) {
                await FirebaseFirestore.instance.collection('saying').doc().set(
                  {
                    'text': messageText,
                    'citation': citation,
                    'genre': _selectItem,
                    'bookmark': 0,
                  },
                );
                Navigator.of(context).pop();
              } else {
                showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                          title: Text("本文、引用元、ジャンル選択は\n必須です"),
                          content: Text(
                            "引用元がご自身の場合はハンドルネーム\nまたは匿名と記載、不明の場合は不明\nと記載してください",
                            style: TextStyle(
                              height: 1.5,
                            ),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('閉じる'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              }
            },
            child: Text(
              '投稿',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
