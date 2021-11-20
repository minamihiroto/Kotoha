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

  @override
  void initState() {
    super.initState();
    reading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0),
      body: Center(
        child: Container(
          child: Column(
            children: [
              ...mapHistory.map(//リストの中でリストを扱っているから...を使う
                (e) {
                  return Text(e['text'],style: TextStyle(color: Colors.white),);
                },
              ).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
