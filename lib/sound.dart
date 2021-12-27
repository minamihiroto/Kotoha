import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';

// class SoundIdAggregation {
//   SoundIdAggregation({this.soundId, this.streamingSoundId});

//   int soundId;
//   int streamingSoundId;
// }

// シングルトンの ChangeNotifier クラス
class SoudPoolController extends ChangeNotifier {
  factory SoudPoolController() => _instance;
  SoudPoolController._internal();
  static final SoudPoolController _instance = SoudPoolController._internal();

  Soundpool pool;
  bool loaded = false;
  List<int> streamingSoundIds = [];
  Map<String, int> soundStreamingIdMap = {};

  void loadSoundPool() {
    if (loaded) {
      return;
    }
    pool = Soundpool(streamType: StreamType.notification);
    loaded = true;

    notifyListeners(); // ChangeNotiferProviderがあるビューに通知できる
  }

  void updateStreamingSoundId(int soundId) {
    if (streamingSoundIds.contains(soundId)) {
      streamingSoundIds.remove(soundId);
    } else {
      streamingSoundIds.add(soundId);
    }
    notifyListeners();
  }

  Future<int> getWindSoundId() async {
    final rawData = await rootBundle.load("sound/wind.mp3");
    return await pool.load(rawData);
  }

  Future<void> startWindSound() async {
    final soundId = await getWindSoundId();
    if (soundStreamingIdMap["wind"] != null) {
      return;
    }
    final soundStreamId = await pool.play(soundId, repeat: -1);
    soundStreamingIdMap["wind"] = soundStreamId;
    updateStreamingSoundId(soundStreamId);
  }

  //あとで共通化する
  Future<int> getInsectSoundId() async {
    var soundId = await rootBundle.load("sound/insect.mp3");
    return await pool.load(soundId);
  }

  Future<void> startInsectSound() async {
    final soundId = await getInsectSoundId();
    if (soundStreamingIdMap["insect"] != null) {
      return;
    }
    final soundStreamId = await pool.play(soundId, repeat: -1);
    soundStreamingIdMap["insect"] = soundStreamId;
    updateStreamingSoundId(soundStreamId);
  }

  Future<void> stopSound(int soundStreamId, String soundName) async {
    await pool.stop(soundStreamId);
    soundStreamingIdMap[soundName] = null;
    updateStreamingSoundId(soundStreamId);
  }
}

class Sound extends StatefulWidget {
  @override
  _SoundState createState() => _SoundState();
}

class _SoundState extends State<Sound> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SoudPoolController>.value(
      value: SoudPoolController()..loadSoundPool(),
      child: Consumer<SoudPoolController>(
        builder: (context, controller, child) {
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
                          onPressed: () async {
                            final streamingId =
                                controller.soundStreamingIdMap["wind"];
                            if (streamingId == null) {
                              await controller.startWindSound();
                              return;
                            }
                            await controller.stopSound(streamingId, "wind");
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text(
                            '風の音',
                            style: TextStyle(
                                //color: sound ? Colors.blue : Colors.grey,
                                ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final streamingId =
                                controller.soundStreamingIdMap["insect"];
                            if (streamingId == null) {
                              await controller.startInsectSound();
                              return;
                            }
                            await controller.stopSound(streamingId, "insect");
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text(
                            '虫の音',
                            style: TextStyle(
                                // color: sound2 ? Colors.blue : Colors.grey,
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
        },
      ),
    );
  }
}
