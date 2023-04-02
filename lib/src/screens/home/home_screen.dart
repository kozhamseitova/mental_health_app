import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

class HomeScreen extends StatelessWidget {
  static const String name = "Маха";
  static const String minutesOfMeditation = "5";
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  HomeScreen({super.key});


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
            return (data != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                tHomePageTitle,
                                style: tsHomePageTitle,
                              ),
                              Text(
                                data.name,
                                style: tsHomePageTitle,
                              )
                            ],
                          ),
                          Text(
                            tHomePageSubTitle,
                            style: tsHomePageSubTitle,
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
                                    tMeditationTimeSubTitle,
                                    style: tsHomePageMeditationSubTitle,
                                  )
                                ],
                              )),
                          Column(
                            children: [
                              Container(
                                width: 200,
                                height: 149,
                                padding: EdgeInsets.only(
                                    left: tDefaultSizeS, top: tDefaultSizeS),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(tHomePageAudio),
                                  ),
                                ),
                                child: Text(tPopularAudio,
                                    style: tsHomePageItemTitle),
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
                                      tPremiumTitle,
                                      style: tsHomePageItemTitle,
                                    ),
                                    Text(
                                        (data.isPremium)
                                            ? "У вас неограниченный\nдоступ к аудио"
                                            : (tPremiumSubTitle),
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
                            tDailyMeditationTitle,
                            style: tsHomePageTitle,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
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
                                      child: Player(user: data, audioId: "",)
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
                                    tAudioListForMeditation,
                                    style: tsHomePageDailyMeditationTitle,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 17, top: 64),
                                  child: Text(
                                    "4 минуты",
                                    style: tsHomePageDailyMeditationSubTitle,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        tRecommendationTitle,
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
                            var data = snapshot.data;
                            return (data != null)
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        (data.length > 3) ? 4 : data.length,
                                    itemBuilder: (context, index) {
                                      final item = data[index];
                                      return Container(
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
