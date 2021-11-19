import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  Future<Map<String, dynamic>> myBook() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final document = snapshot.docs.first.data();
    return document;
  }

  List<Map<String, dynamic>> mapBookmark = [];

  @override
  void initState() {
    super.initState();
    myBook().then(
      (Map<String, dynamic> value) async {
        final bookmarkList = value['bookmark'] as List;
        mapBookmark = await Future.wait(
          bookmarkList.map(
            (e) async {
              final doc = await (e as DocumentReference).get();
              return doc.data();
            },
          ).toList(),
        );
        setState(() {});
      },
    );
  }

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
            children: mapBookmark.map((document) {
              return ListTile(
                title: Text('${document['text']}'),
                subtitle: Text('${document['genre']}'),
                leading: Text('${document['citation']}'),
              );
            }).toList(),
            // children: [
            //   Container(
            //     margin:
            //         EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
            //     child: Text(
            //       '今まで投稿されたものは二度と復元することはできません。\nもし削除されるにしてもその前に別の場所に保存しておいてください。それは過去のあなたの支えになったはずの言葉だから。',
            //       maxLines: 3,
            //       overflow: TextOverflow.ellipsis,
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: Colors.white,
            //         height: 2.25,
            //       ),
            //       textAlign: TextAlign.center,
            //       textHeightBehavior: TextHeightBehavior(
            //         applyHeightToFirstAscent: false,
            //         applyHeightToLastDescent: false,
            //       ),
            //     ),
            //   ),
            //   Container(
            //     margin: EdgeInsets.only(right: 10, bottom: 10),
            //     child: Text(
            //       'ビジネス | ジェフベゾス',
            //       maxLines: 3,
            //       overflow: TextOverflow.ellipsis,
            //       style: TextStyle(
            //         fontSize: 14,
            //         color: Colors.white70,
            //         height: 2.75,
            //       ),
            //       textAlign: TextAlign.center,
            //       textHeightBehavior: TextHeightBehavior(
            //         applyHeightToFirstAscent: false,
            //         applyHeightToLastDescent: false,
            //       ),
            //     ),
            //   ),
            //   Divider(color: Colors.white54),
            // ],
          ),
        ),
      ),
    );
  }
}
