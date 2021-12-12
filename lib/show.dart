import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Show extends StatefulWidget {
  final String genre;
  final String text;
  final String citation;
  Show(this.citation, this.text, this.genre);

  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("movies/background-sample.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.fill,
            child: SizedBox(
              width: _controller.value.size?.width ?? 0,
              height: _controller.value.size?.height ?? 0,
              child: VideoPlayer(_controller),
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
            child: Center(
              child: Container(
                width: 310,
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 240,
                        margin: EdgeInsets.only(top: 10),
                        child: SingleChildScrollView(
                          child: Text(
                            widget.text.replaceAll('\\n', '\n'),
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
                        '${widget.genre} | ${widget.citation}',
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
        ),
      ],
    );
  }
}
