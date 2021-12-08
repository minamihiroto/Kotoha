import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';

class Sound extends StatefulWidget {
  @override
  _SoundState createState() => _SoundState();
}

class _SoundState extends State<Sound> {
  soundStart() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);
    int soundId = await rootBundle.load("sound/wind.mp3").then(
      (ByteData soundData) {
        return pool.load(soundData);
      },
    );
    await pool.play(soundId, repeat: -1);
  }

  soundStart2() async {
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
                onPressed: () {
                  soundStart();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text('風の音'),
              ),
              TextButton(
                onPressed: () {
                  soundStart2();
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
