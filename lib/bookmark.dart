import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/show.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  List<Map<String, dynamic>> mapBookmark = [];

  Future reading() async {
    var box = await Hive.openBox('bookmark');
    final bookmark = List<String>.from(box.values);
    final addedBookmarks = <String>[];
    await box.clear(); //一度全消し
    for (final docId in bookmark) {
      final ds = await FirebaseFirestore.instance
          .collection('saying')
          .doc(docId)
          .get();
      if (ds.exists) {
        if (!addedBookmarks.contains(ds.id)) {
          //重複しているもの以外を追加する
          addedBookmarks.add(ds.id);
          mapBookmark.add(ds.data());
          await box.add(ds.id); //あるものだけ追加
        }
      }
    }
    setState(() {});
  }

  String switchBun(int genre) {
    switch (genre) {
      case 2:
        return 'ビジネス';
      case 3:
        return '歌詞';
      case 4:
        return '励まし';
    }
    return 'エラー';
  }

  @override
  void initState() {
    super.initState();
    reading();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...mapBookmark.map(
              //リストの中でリストを扱っているから...を使う
              (e) {
                final citation = e['citation'];
                final text = e['text'];
                final genre = e['genre'];
                final bookmark = e['bookmark'];
                final docId = e['id'];
                setState(() {});
                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      // 画面遷移
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              Show(citation, text, switchBun(genre)),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: 30, left: 10, right: 10, bottom: 20),
                            child: Center(
                              child: Text(
                                text,
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
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  '${switchBun(genre)} | $citation',
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
                              Container(
                                child: GestureDetector(
                                    onTap: () async {
                                      var box = await Hive.openBox('bookmark');
                                      final listBookmark =
                                          List<String>.from(box.values);
                                      showDialog(
                                        context: context,
                                        builder: (_) => CupertinoAlertDialog(
                                          content: Text(
                                            "$text",
                                            style: TextStyle(
                                              height: 1.5,
                                            ),
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text('ブックマークから外す'),
                                              onPressed: () async {
                                                if (bookmark > 0) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('saying')
                                                      .doc(docId)
                                                      .update(
                                                    {
                                                      'bookmark':
                                                          FieldValue.increment(
                                                              -1)
                                                    },
                                                  );
                                                }
                                                await box.delete(listBookmark
                                                    .indexOf(docId));
                                                Navigator.of(context).pop();
                                                setState(() {});// 再描画されないからmainページに戻ってもブックマークされっぱなしの時がある
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text('キャンセル'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.delete_forever_rounded,
                                      color: Colors.grey,
                                    )),
                              ),
                            ],
                          ),
                          Divider(color: Colors.white54),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
