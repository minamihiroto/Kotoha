import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/bookmark.dart';
import 'package:project/history.dart';

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "マイブック",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.withOpacity(0),
        bottom: TabBar(
          labelStyle: TextStyle(fontSize: 18),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.only(right: 40, left: 40),
          controller: _tabController,
          tabs: _buildTabs(context),
          indicatorColor: Colors.white,
        ),
      ),
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0.85),
      body: TabBarView(
        controller: _tabController,
        children: _buildTabPages(),
      ),
    );
  }

  List<Widget> _buildTabs([BuildContext context]) {
    return [
      Tab(text: '履歴'),
      Tab(text: 'ブックマーク'),
    ];
  }

  /// タブの中身として表示するPage(Widget)の配列を生成
  List<Widget> _buildTabPages() {
    return [
      History(),
      Bookmark(),
    ];
  }
}
