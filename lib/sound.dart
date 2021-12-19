import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';

class Sound extends StatefulWidget {
  @override
  _SoundState createState() => _SoundState();
}

class _SoundState extends State<Sound> {
  bool _isDisabled = false; //なんちゃって連打防止
  bool sound = false; // 音1が鳴っているかの判断
  bool sound2 = false; // 音2が鳴っているかの判断

  //soundpool
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  //下記をHiveにする
  int soundStreamId;
  int soundStreamId2;

  soundLoad() async {
    var soundId = await rootBundle.load("sound/wind.mp3");
    return await pool.load(soundId);
  }

  soundStart() async {
    var soundStart = await soundLoad();
    soundStreamId = await pool.play(soundStart, repeat: -1);
  }

  soundStop() async {
    if (soundStreamId != null) {
      await pool.stop(soundStreamId);
    }
  }

  soundLoad2() async {
    var soundId2 = await rootBundle.load("sound/insect.mp3");
    return await pool.load(soundId2);
  }

  soundStart2() async {
    var soundStart2 = await soundLoad2();
    soundStreamId2 = await pool.play(soundStart2, repeat: -1);
  }

  soundStop2() async {
    if (soundStreamId2 != null) {
      await pool.stop(soundStreamId2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボカシにしたい（ブラー？？）
      backgroundColor: Colors.black.withOpacity(0),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 40,right: 30,left: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: _isDisabled
                        ? null
                        : () {
                            if (!_isDisabled) {
                              if (!sound) {
                                // サウンドが今なっているかどうかの判断
                                setState(() => _isDisabled = true);
                                soundStart();
                                sound = true;
                                setState(() => _isDisabled = false);
                              } else {
                                setState(() => _isDisabled = true);
                                soundStop();
                                sound = false;
                                setState(() => _isDisabled = false);
                              }
                            }
                            setState(() {});
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text('風の音',
                      style: TextStyle(
                        color: sound ? Colors.blue : Colors.grey,
                      ),),
                  ),
                  TextButton(
                    onPressed: _isDisabled
                        ? null
                        : () {
                            if (!_isDisabled) {
                              if (!sound2) {
                                setState(() => _isDisabled = true);
                                soundStart2();
                                sound2 = true;
                                setState(() => _isDisabled = false);
                              } else {
                                setState(() => _isDisabled = true);
                                soundStop2();
                                sound2 = false;
                                setState(() => _isDisabled = false);
                              }
                            }
                            setState(() {});
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text('虫の音',
                      style: TextStyle(
                        color: sound2 ? Colors.blue : Colors.grey,
                      ),),
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