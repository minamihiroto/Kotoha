import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/comment.dart';
import 'package:project/change.dart';
import 'package:project/book.dart';
import 'package:project/setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:share/share.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = 'エラー';
  String citation = 'エラー';
  int genre;
  String genreMessage = 'エラー';
  int bookmark;
  String id;
  List<String> listBookmark = [];

  Future<Map<String, dynamic>> wiseSaying() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('saying').get();
    final docs = snapshot.docs;
    docs.shuffle();
    id = docs.first.id;
    return docs.first.data();
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

  Future<void> mainLoop() async {
    // 10秒ごとに実行
    while (true) {
      await Future<void>.delayed(
        const Duration(seconds: 10),
      );
      wiseSaying().then(
        (Map<String, dynamic> value) {
          text = value['text'];
          citation = value['citation'];
          genre = value['genre'];
          switchBun();
          setState(() {});
        },
      );
    }
  }

  fetchListBookmark() async {
    var box = await Hive.openBox('bookmark');
    listBookmark = List<String>.from(box.values);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchListBookmark();
    wiseSaying().then(
      (Map<String, dynamic> value) {
        text = value['text'];
        citation = value['citation'];
        genre = value['genre'];
        bookmark = value['bookmark'];
        switchBun();
        setState(() {});
      },
    );
    mainLoop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('movies/background-sample.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 310,
            margin: EdgeInsets.only(top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //テキストコンテンツ、引用文周り
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.share_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Share.share('共有');
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                listBookmark.contains(id)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                var box = await Hive.openBox('bookmark');
                                if (listBookmark.contains(id)) {
                                  bookmark -= 1;
                                  await FirebaseFirestore.instance
                                      .collection('saying')
                                      .doc(id)
                                      .update(
                                    {'bookmark': bookmark},
                                  );
                                  listBookmark.remove(id);
                                  await box.delete(listBookmark.indexOf(id));
                                } else {
                                  bookmark += 1;
                                  await FirebaseFirestore.instance
                                      .collection('saying')
                                      .doc(id)
                                      .update(
                                    {'bookmark': bookmark},
                                  );
                                  listBookmark.add(id);
                                  await box.add(id);
                                }
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: 240,
                          margin: EdgeInsets.only(top: 10),
                          child: SingleChildScrollView(
                            child: Text(
                              text.replaceAll('\\n', '\n'),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                height: 2.75,
                              ),
                              textAlign: TextAlign.center,
                              textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false,
                                applyHeightToLastDescent: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          '$genreMessage | $citation',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // メニュー群
                  margin: EdgeInsets.only(bottom: 40),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // 画面遷移
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  Comment(),
                            ),
                          );
                        },
                        child: Container(
                          child: SvgPicture.asset(
                            'assets/comment.svg',
                            color: Color(0xffffffff),
                            semanticsLabel: 'comment',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black54,
                        ),
                        height: 50,
                        width: 280,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // 画面遷移
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            Change(),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/change.svg',
                                color: Color(0xffffffff),
                                semanticsLabel: 'comment',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // 画面遷移
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) => Book(),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/book.svg',
                                color: Color(0xffffffff),
                                semanticsLabel: 'comment',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // 画面遷移
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            Setting(),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/setting.svg',
                                color: Color(0xffffffff),
                                semanticsLabel: 'comment',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
