import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> mapHistory = [];
  String text = 'エラー';
  int genre;
  String genreMessage = 'エラー';
  String citation = 'エラー';

  Future reading() async {
    var box = await Hive.openBox('history');
    final history = List<String>.from(box.values);
    FirebaseFirestore.instance.collection('saying').doc();
    mapHistory = await Future.wait(
      history.map(
        (e) async {
          final doc = await FirebaseFirestore.instance
              .collection('saying')
              .doc(e)
              .get();
          return doc.data();
        },
      ).toList(),
    );
    setState(() {});
  }

  switchBun() {
    switch (genre) {
      case 2:
        return genreMessage = 'ビジネス';
      case 3:
        return genreMessage = '歌詞';
      case 4:
        return genreMessage = '励まし';
    }
  }

  @override
  void initState() {
    super.initState();
    reading();
    switchBun();
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
                ...mapHistory.map(
                  //リストの中でリストを扱っているから...を使う
                  (e) {
                    citation = e['citation'];
                    text = e['text'];
                    switchBun();
                    setState(() {});
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
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
                              '$genreMessage | $citation',
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
