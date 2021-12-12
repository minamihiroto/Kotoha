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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0),
      body: Center(
        child: Container(
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
                              if (box.getAt(0) !=
                                  "movies/background-sample.mp4") {
                                await box.clear();
                                await box.add("movies/background-sample.mp4");
                              }
                            }
                            setState(() {});
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text('動画１'),
                  ),
                  TextButton(
                    onPressed: _isDisabled2
                        ? null
                        : () async {
                            if (!_isDisabled2) {
                              var box = await Hive.openBox('movie');
                              if (box.getAt(0) != "movies/wave.mp4") {
                                await box.clear();
                                await box.add("movies/wave.mp4");
                              }
                            }
                            setState(() {});
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text('動画２'),
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
