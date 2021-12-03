import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/show.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> mapHistory = [];

  Future reading() async {
    var box = await Hive.openBox('history');
    final bookmark = List<String>.from(box.values);
    await box.clear(); //一度全消し
    for (final docId in bookmark) {
      final ds = await FirebaseFirestore.instance
          .collection('saying')
          .doc(docId)
          .get();
      if (ds.exists) {
        mapHistory.add(ds.data());
        await box.add(ds.id); //あるものだけ追加
      }
    }
    setState(() {});
  }

  switchBun(int genre) {
    switch (genre) {
      case 2:
        return 'ビジネス';
      case 3:
        return '歌詞';
      case 4:
        return '励まし';
    }
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
      backgroundColor: Colors.black.withOpacity(0),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ...mapHistory.map(
                //リストの中でリストを扱っているから...を使う
                (e) {
                  final citation = e['citation'];
                  final text = e['text'];
                  final genre = e['genre'];
                  final mark = e['bookmark'];
                  setState(() {});
                  return Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        GestureDetector(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'ブックマーク数：$mark',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Text(
                                            '${switchBun(genre)} | $citation',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white70,
                                              height: 2.75,
                                            ),
                                            textAlign: TextAlign.center,
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                              applyHeightToFirstAscent: false,
                                              applyHeightToLastDescent: false,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: GestureDetector(
                                              onTap: () async {
                                                var box = await Hive.openBox(
                                                    'history');
                                                final listHistory =
                                                    List<String>.from(
                                                        box.values);
                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      CupertinoAlertDialog(
                                                    content: Text(
                                                      "$text",
                                                      style: TextStyle(
                                                        height: 1.5,
                                                      ),
                                                    ),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                        child: Text('投稿を削除する'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      CupertinoDialogAction(
                                                        child: Text('キャンセル'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Colors.white54),
                      ],
                    ),
                  );
                },
              ).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
