import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('movies/background-sample.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Container(
            width: 310,
            margin: EdgeInsets.only(top: 110),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          '会社には2種類ある。\n高く売るために努力する会社と、安く売るために努力する会社だ。我々は後者になる。',
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
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          'ビジネス | ジェフ・ベゾス',
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
                      SvgPicture.asset(
                        'assets/comment.svg',
                        color: Color(0xffffffff),
                        semanticsLabel: 'comment',
                        width: 50,
                        height: 50,
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
                            SvgPicture.asset(
                              'assets/change.svg',
                              color: Color(0xffffffff),
                              semanticsLabel: 'comment',
                              width: 30,
                              height: 30,
                            ),
                            SvgPicture.asset(
                              'assets/book.svg',
                              color: Color(0xffffffff),
                              semanticsLabel: 'comment',
                              width: 30,
                              height: 30,
                            ),
                            SvgPicture.asset(
                              'assets/setting.svg',
                              color: Color(0xffffffff),
                              semanticsLabel: 'comment',
                              width: 30,
                              height: 30,
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
