import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';

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

  Future<int> getSoundId(SoundType soundType) async {
    final rawData = await rootBundle.load(soundType.soundFileName);
    return await pool.load(rawData);
  }

  Future<void> startSound(SoundType soundType) async {
    final soundId = await getSoundId(soundType);
    if (soundStreamingIdMap[soundType.str] != null) {
      return;
    }
    final soundStreamId = await pool.play(soundId, repeat: -1);
    soundStreamingIdMap[soundType.str] = soundStreamId;
    updateStreamingSoundId(soundStreamId);
  }

  Future<void> stopSound(int soundStreamId, SoundType soundType) async {
    await pool.stop(soundStreamId);
    soundStreamingIdMap[soundType.str] = null;
    updateStreamingSoundId(soundStreamId);
  }
}

enum SoundType {
  wind,
  insect,
}

extension SoundTypeExtention on SoundType {
  String get str {
    switch (this) {
      case SoundType.wind:
        return 'sound/wind.mp3';
      case SoundType.insect:
        return 'sound/insect.mp3';
      default:
        return '';
    }
  }

  String get soundFileName {
    switch (this) {
      case SoundType.wind:
        return 'wind';
      case SoundType.insect:
        return 'insect';
      default:
        return '';
    }
  }
}

class Sound extends StatefulWidget {
  @override
  _SoundState createState() => _SoundState();
}

class _SoundState extends State<Sound> {
  bool isStreaming(BuildContext context, SoundType soundType) {
    final controller = Provider.of<SoudPoolController>(context);
    final streaming = controller.soundStreamingIdMap[soundType.str];
    if (streaming == null) {
      return false;
    }
    return true;
  }

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
                            final streamingId = controller
                                .soundStreamingIdMap[SoundType.wind.str];
                            if (streamingId == null) {
                              await controller.startSound(SoundType.wind);
                              return;
                            }
                            await controller.stopSound(
                                streamingId, SoundType.wind);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text(
                            '風の音',
                            style: TextStyle(
                              color: isStreaming(context, SoundType.wind)
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final streamingId = controller
                                .soundStreamingIdMap[SoundType.insect.str];
                            if (streamingId == null) {
                              await controller.startSound(SoundType.insect);
                              return;
                            }
                            await controller.stopSound(
                                streamingId, SoundType.insect);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text(
                            '虫の音',
                            style: TextStyle(
                              color: isStreaming(context, SoundType.insect)
                                  ? Colors.blue
                                  : Colors.grey,
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
