import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Movie extends StatefulWidget {
  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  bool _isDisabled2 = false; //なんちゃって連打防止
  List<String> listMovie = [];
  int movieKind;

  Future<void> movieSet() async {
    var box = await Hive.openBox('movie');
    switch (box.getAt(0)) {
      case "movies/background-sample.mp4":
        movieKind = 1;
        break;
      case "movies/wave.mp4":
        movieKind = 2;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      await movieSet();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 40, right: 30, left: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: _isDisabled2
                        ? null
                        : () async {
                            if (!_isDisabled2) {
                              var box = await Hive.openBox('movie');
                              if (movieKind != 1) {
                                await box.clear();
                                await box.add("movies/background-sample.mp4");
                                movieKind = 1;
                              }
                            }
                            setState(() {});
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text(
                      '動画１',
                      style: TextStyle(
                        color: movieKind == 1 ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _isDisabled2
                        ? null
                        : () async {
                            if (!_isDisabled2) {
                              var box = await Hive.openBox('movie');
                              if (movieKind != 2) {
                                await box.clear();
                                await box.add("movies/wave.mp4");
                                movieKind = 2;
                              }
                            }
                            setState(() {});
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text(
                      '動画２',
                      style: TextStyle(
                        color: movieKind == 2 ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
