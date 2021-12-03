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
    await box.clear(); //一度全消し
    for (final docId in bookmark) {
      final ds = await FirebaseFirestore.instance
          .collection('saying')
          .doc(docId)
          .get();
      if (ds.exists) {
        mapBookmark.add(ds.data());
        await box.add(ds.id); //あるものだけ追加
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
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...mapBookmark.map(
                  //リストの中でリストを扱っているから...を使う
                  (e) {
                    final citation = e['citation'];
                    final text = e['text'];
                    final genre = e['genre'];
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
                                  Show(citation,text,switchBun(genre)),
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
                              Container(
                                margin: EdgeInsets.only(right: 10, bottom: 10),
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
        ),
      ),
    );
  }
}
