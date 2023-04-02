import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/services/db_service.dart';
import 'package:provider/provider.dart';

import '../../models/meditation.dart';
import '../../models/user_data.dart';

class Player extends StatefulWidget {
  final UserData user;
  final String audioId;
  const Player({Key? key, required this.user, required this.audioId}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String path = "audios/1.mp3";
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  int sessions = 0;
  int minutes = 0;

  @override
  void initState() {
    super.initState();

    minutes = widget.user.minutes;

    setAudio(path);

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });

  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }


  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;

    return Material(
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: Builder(
          builder: (BuildContext context) {
            var _auth = Provider.of<AuthProvider>(context);
            return StreamBuilder(
              stream: DBService.instance.getUserData(_auth.user!.uid),
              builder: (context, snapshot) {
                var d = snapshot.data;
                  if (d != null) {
                    audioPlayer.onPlayerComplete.listen((event) {
                      int dur = duration.inMinutes;
                      DBService.instance.updateUserData(
                          widget.user.id, d.minutes + dur, d.sessions + 1, d.lastAudio);
                    });
                }
                return Container(
                    decoration: BoxDecoration(
                      color: cBackgroundColor,
                    ),
                    width: widthScreen,
                    height: heightScreen,
                    child: StreamBuilder<Meditation>(
                      stream: DBService.instance.getAudio(widget.audioId),
                      builder: (context, snapshot) {
                        var data = snapshot.data;
                        while (data == null) {
                          return  SizedBox(
                            height: heightScreen / 2,
                            child: SpinKitWanderingCubes(
                              color: Colors.white,
                              size: 50,
                            ),
                          );
                        }
                        setAudio(data.link);
                        return Column(
                          children: [
                            SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(onPressed: (){Navigator. of(context). pop();}, icon: Icon(Icons.close_rounded))
                              ],
                            ),

                            SizedBox(height: 50,),
                            Container(
                              width: 250,
                              height: 250,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: cBackgroundColor,
                                image: DecorationImage(
                                  image: AssetImage(
                                    (data.category == "meditation") ? "assets/images/med.jpg" : "assets/images/audi.jpg",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius:
                                BorderRadius.circular(15),
                              ),
                            ),
                            SizedBox(height: 20,),
                            DefaultTextStyle(style: tsHomePageTitle, child: Text(data.title)),
                            SizedBox(height: 20,),

                            Slider(
                              min: 0,
                              max: duration.inSeconds.toDouble(),
                              value: position.inSeconds.toDouble(),
                              onChanged: (value) async {
                                final pos = Duration(seconds: value.toInt());
                                await audioPlayer.seek(pos);

                                await audioPlayer.resume();
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(formatTime(position)),
                                    Text(formatTime(duration - position)),
                                  ],
                                )
                            ),
                            SizedBox(height: 40,),
                            CircleAvatar(
                              radius: 35,
                              child: IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                ),
                                iconSize: 50,
                                onPressed: () async {
                                  if (isPlaying) {
                                    await audioPlayer.pause();
                                  } else {
                                    await audioPlayer.resume();
                                  }
                                },
                              ),
                            )
                          ],
                        );
                      },
                    )
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future setAudio(String path) async {
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    audioPlayer.setSourceAsset(path);
  }
}

