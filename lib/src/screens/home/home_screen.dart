import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/models/meditation.dart';
import 'package:mental_health_app/src/models/user_data.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/screens/home/recommendations.dart';
import 'package:mental_health_app/src/screens/player/player.dart';
import 'package:mental_health_app/src/services/db_service.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/image_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String name = "Маха";
  static const String minutesOfMeditation = "5";
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isRus = false;

  void _changeLang(bool lang) {
    setState(() {
      isRus = lang;
    });
  }

  @override
  Widget build(BuildContext context) {

    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });

    audioPlayer.onDurationChanged.listen((event) {
      duration = event;
    });

    audioPlayer.onPositionChanged.listen((event) {
      position = position;
    });

    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;

    return Container(
      height: heightScreen,
      width: widthScreen,
      padding: EdgeInsets.only(
          top: widthScreen * 0.1,
          right: widthScreen * 0.03,
          left: widthScreen * 0.03),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(tWelcomePageImage), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
          child: ChangeNotifierProvider<AuthProvider>.value(
            value: AuthProvider.instance,
            child: homePageUI(heightScreen, widthScreen),
          )),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(':');
  }

  Widget homePageUI(double heightScreen, double widthScreen) {

    return Builder(
      builder: (BuildContext context) {
        var _auth = Provider.of<AuthProvider>(context);
        return StreamBuilder<UserData>(
          stream: DBService.instance.getUserData(_auth.user!.uid),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                isRus = data.lang == "rus" ? true : false;
              }));
            }
            return (data != null)
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              data.lang == "rus" ? tHomePageTitle : tHomePageTitleQaz,
                              style: tsHomePageTitle,
                            ),
                            Text(
                              data.name,
                              style: tsHomePageTitle,
                            )
                          ],
                        ),
                        Text(
                          data.lang == "rus" ? tHomePageSubTitle : tHomePageSubTitleQaz,
                          style: tsHomePageSubTitle,
                        )
                      ],
                    ),
                    FlutterSwitch(
                        value: isRus,
                        width: 60,
                        height: 30,
                        toggleSize: 20,
                        padding: 0,
                        activeText: "Qaz",
                        inactiveText: "Rus",
                        showOnOff: true,
                        onToggle: (bool val) {
                          _changeLang(val);
                          DBService.instance.updateLang(data.id, val ? "rus": "qaz");
                        }
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 141,
                        height: 238,
                        padding: const EdgeInsets.only(
                            left: tDefaultSizeS, top: tDefaultSizeS),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(tHomePageMeditation),
                              fit: BoxFit.fill,
                            ),
                            borderRadius:
                            BorderRadius.circular(tDefaultSizeS)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.minutes.toString() + tMeditationTimeTitle,
                              style: tsHomePageMeditationTitle,
                            ),
                            Text(
                              data.lang == "rus" ? tMeditationTimeSubTitle : tMeditationTimeSubTitleQaz,
                              style: tsHomePageMeditationSubTitle,
                            )
                          ],
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (data.lastAudio == "") ? Material(
                          child: InkWell(
                            onTap: () {
                              showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel:
                                  MaterialLocalizations.of(context)
                                      .modalBarrierDismissLabel,
                                  barrierColor: Colors.black45,
                                  pageBuilder: (BuildContext ctx,
                                      Animation animation,
                                      Animation secondaryAnimation) {
                                    return Container(
                                        width: widthScreen,
                                        height: heightScreen,
                                        color: cBackgroundColor,
                                        child: Player(user: data, audioId: "zgZPM093EXyYmTVSGpSM",)
                                    );
                                  });
                            },
                            child: Container(
                              width: 200,
                              height: 149,
                              padding: EdgeInsets.only(
                                  left: tDefaultSizeS, top: tDefaultSizeS),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(tHomePageAudio),
                                ),
                              ),
                              child: Text(
                                  data.lang == "rus" ? "Начните медитировать" : "Медитацияны бастаңыз",
                                  style: tsHomePageItemTitle),
                            ),
                          ),
                        ) : Material(
                          child: InkWell(
                              onTap: () {
                                showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel:
                                    MaterialLocalizations.of(context)
                                        .modalBarrierDismissLabel,
                                    barrierColor: Colors.black45,
                                    pageBuilder: (BuildContext ctx,
                                        Animation animation,
                                        Animation secondaryAnimation) {
                                      return Container(
                                          width: widthScreen,
                                          height: heightScreen,
                                          color: cBackgroundColor,
                                          child: Player(user: data, audioId: data.lastAudio,)
                                      );
                                    });
                              },
                              child: Container(
                                width: 200,
                                height: 149,
                                padding: EdgeInsets.only(
                                    left: tDefaultSizeS, top: tDefaultSizeS),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(tHomePageAudio),
                                  ),
                                ),
                                child: Text(
                                    data.lang == "rus" ? "Часто прослушиваемое аудио" : "Жиі тыңдалатын аудио",
                                    style: tsHomePageItemTitle),
                              )
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 95,
                          padding: EdgeInsets.only(left: tDefaultSizeS),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(tHomePagePremium),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                data.lang == "rus" ? tPremiumTitle : tPremiumTitleQaz,
                                style: tsHomePageItemTitle,
                              ),
                              Text(
                                  (data.isPremium)
                                      ? data.lang == "rus" ? "У вас неограниченный\nдоступ к аудио" : "Сізде аудиоға шектеусіз қол жетімділік бар"
                                      : (data.lang == "rus"? tPremiumSubTitle : tPremiumSubTitleQaz),
                                  style: tsHomePageItemSubTitle)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.lang == "rus" ? tDailyMeditationTitle : tDailyMeditationTitleQaz,
                      style: tsHomePageTitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      child: InkWell(
                        onTap: () {
                          showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel:
                              MaterialLocalizations.of(context)
                                  .modalBarrierDismissLabel,
                              barrierColor: Colors.black45,
                              pageBuilder: (BuildContext ctx,
                                  Animation animation,
                                  Animation secondaryAnimation) {
                                return Container(
                                    width: widthScreen,
                                    height: heightScreen,
                                    color: cBackgroundColor,
                                    child: Player(user: data, audioId: "zgZPM093EXyYmTVSGpSM",)
                                );
                              });
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 350,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(tHomePageDailyAudio),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 17, top: 45),
                              child: Text(
                                data.lang == "rus" ? tAudioListForMeditation : tAudioListForMeditationQaz,
                                style: tsHomePageDailyMeditationTitle,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 17, top: 64),
                              child: Text(
                                "5 минут",
                                style: tsHomePageDailyMeditationSubTitle,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  data.lang == "rus" ? tRecommendationTitle : tRecommendationTitleQaz,
                  style: tsHomePageTitle,
                ),
                SizedBox(
                  height: tDefaultSizeM,
                ),
                SizedBox(
                  height: 130,
                  child: StreamBuilder<List<Meditation>>(
                    stream:
                    DBService.instance.getAudios(Category.meditation),
                    builder: (context, snapshot) {
                      var d = snapshot.data;
                      return (d != null)
                          ? ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                        (d.length > 3) ? 4 : d.length,
                        itemBuilder: (context, index) {
                          final item = d[index];
                          return
                            Material(
                              child: InkWell(
                                  onTap: () {
                                    showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel:
                                        MaterialLocalizations.of(context)
                                            .modalBarrierDismissLabel,
                                        barrierColor: Colors.black45,
                                        pageBuilder: (BuildContext ctx,
                                            Animation animation,
                                            Animation secondaryAnimation) {
                                          return Container(
                                              width: widthScreen,
                                              height: heightScreen,
                                              color: cBackgroundColor,
                                              child: Player(user: data, audioId: d[index].id,)
                                          );
                                        });
                                  }, child: Container(
                                padding: EdgeInsets.only(
                                    bottom: tDefaultSizeS),
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(tHomePageRec),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(
                                        tDefaultSizeS)),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      height: 12,
                                      width: 114,
                                      decoration: BoxDecoration(
                                        color: cTextColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                tDefaultSizeS)),
                                      ),
                                      child: Text(
                                        item.title,
                                        style: tsHomePageItemSubTitle,
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              )),
                            );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              width: tDefaultSizeS,
                            ),
                      )
                          : SizedBox(
                        height: 150,
                        child: SpinKitWanderingCubes(
                          color: Colors.white,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
                : SizedBox(
              height: heightScreen / 2,
              child: SpinKitWanderingCubes(
                color: Colors.white,
                size: 50,
              ),
            );
          },
        );
      },
    );
  }
}

