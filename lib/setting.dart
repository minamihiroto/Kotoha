import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/adsense.dart';
import 'package:project/premium.dart';
import 'package:project/search.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0.85),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "設定",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                    right: 10,
                    left: 40,
                    bottom: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // 画面遷移
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              Adsense(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '広告が表示される理由',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // 画面遷移
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              Premium(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'プレミアムプランに変更する',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // 画面遷移
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              Search(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '表示投稿の絞り込み',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      var box = await Hive.openBox('history');
                      final listHistory = List<String>.from(box.values);
                      showDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                                title: Text("一括削除"),
                                content: Text(
                                  "今まで投稿されたものは\n二度と復元することはできません。\nもし削除されるにしてもその前に\n別の場所に保存しておいてください。\nそれは過去のあなたの\n支えになったはずの言葉だから。",
                                  style: TextStyle(
                                    height: 1.5,
                                  ),
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('キャンセル'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text('一括削除'),
                                    onPressed: () async {
                                      await Future.wait(
                                        listHistory.map(
                                          (e) => FirebaseFirestore.instance
                                              .collection('saying')
                                              .doc(e)
                                              .delete(),
                                        ),
                                      );
                                      await box.clear();
                                      Navigator.of(context).pop();
                                      showDialog(
                                        context: context,
                                        builder: (_) => CupertinoAlertDialog(
                                          title: Text('削除成功'),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '今までの投稿の一括削除',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://google.com')) {
                        await launch('https://google.com');
                      } else {
                        throw 'エラー：開くことができませんでした';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'お知らせ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://google.com')) {
                        await launch('https://google.com');
                      } else {
                        throw 'エラー：開くことができませんでした';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'お問い合わせ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Share.share('共有');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'アプリのシェア',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://google.com')) {
                        await launch('https://google.com');
                      } else {
                        throw 'エラー：開くことができませんでした';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'レビューする',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://google.com')) {
                        await launch('https://google.com');
                      } else {
                        throw 'エラー：開くことができませんでした';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '公式Twitter',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://google.com')) {
                        await launch('https://google.com');
                      } else {
                        throw 'エラー：開くことができませんでした';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '公式Instagram',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://google.com')) {
                        await launch('https://google.com');
                      } else {
                        throw 'エラー：開くことができませんでした';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '利用規約',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://google.com')) {
                        await launch('https://google.com');
                      } else {
                        throw 'エラー：開くことができませんでした';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'プライバシーポリシー',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white54),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 30,
                    left: 40,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://google.com')) {
                        await launch('https://google.com');
                      } else {
                        throw 'エラー：開くことができませんでした';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'お世話になった方々',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 50,
                  ),
                  child: Center(
                    child: Text(
                      'v0.0.1',
                      style: TextStyle(
                        fontSize: 14,
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
