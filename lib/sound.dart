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

  soundStart() async {
    //これを分解したい ロードと再生 await pool.stop(soundId);も追加
    Soundpool pool = Soundpool(streamType: StreamType.notification);
    int soundId = await rootBundle.load("sound/wind.mp3").then(
      (ByteData soundData) {
        return pool.load(soundData);
      },
    );
    await pool.play(soundId, repeat: -1);
  }

  soundStart2() async {
    //これを分解したい ロードと再生 await pool.stop(soundId);も追加
    Soundpool pool = Soundpool(streamType: StreamType.notification);
    int soundId = await rootBundle.load("sound/insect.mp3").then(
      (ByteData soundData) {
        return pool.load(soundData);
      },
    );
    await pool.play(soundId, repeat: -1);
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
              TextButton(
                onPressed: _isDisabled
                    ? null
                    : () {
                        if (!_isDisabled) {
                          if (!sound) {// サウンドが今なっているかどうかの判断
                            setState(() => _isDisabled = true);
                            soundStart();
                            sound = true;
                            setState(() => _isDisabled = false);
                          } else {
                            setState(() => _isDisabled = true);
                            // soundStop();
                            sound = false;
                            setState(() => _isDisabled = false);
                          }
                        }
                        setState(() {});
                      },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text('風の音'),
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
                            // soundStop2();
                            sound2 = false;
                            setState(() => _isDisabled = false);
                          }
                        }
                        setState(() {});
                      },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text('虫の音'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
