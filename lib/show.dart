import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Show extends StatefulWidget {
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  String text = 'エラー';
  String citation = 'エラー';
  int genre;
  String genreMessage = 'エラー';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('movies/background-sample.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 30),
              child: Column(
                children: [
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
          ),
        ),
      ],
    );
  }
}
