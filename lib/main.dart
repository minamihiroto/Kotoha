import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/comment.dart';
import 'package:project/change.dart';
import 'package:project/bookmark.dart';
import 'package:project/setting.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  Future<void> wiseSaying() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('saying').get();
    final text = snapshot.docs.first.data()['text'];
    final citation = snapshot.docs.first.data()['citation'];
    return [text, citation];
  }

  @override
  void initState() {
    super.initState();
    // wiseSaying().then(
    //   (String value) => text = value,
    //   (String value) => citation = value,
    // );
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
            margin: EdgeInsets.only(top: 110),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //テキストコンテンツ、引用文周り
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Icon(
                                Icons.share_rounded,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.bookmark_border_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            text,
                            maxLines: 8,
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
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          citation,
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
                                        (BuildContext context, _, __) =>
                                            Bookmark(),
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