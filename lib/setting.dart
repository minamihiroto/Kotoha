import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0.85),
      appBar: AppBar(
        title: const Text("設定"),
        backgroundColor: Colors.blue.withOpacity(0),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      '広告が表示される理由',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      'プレミアムプランに変更する',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      '表示投稿の絞り込み',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      '今までの投稿の一括削除',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      'お問い合わせ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      'お知らせ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      'アプリのシェア',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      'レビューする',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      '公式Twitter',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      '公式Instagram',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      '利用規約',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      'プライバシーポリシー',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => MyApp(),
                        ),
                      );
                    },
                    child: Text(
                      '開発にあたり、お世話になった方達',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
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
