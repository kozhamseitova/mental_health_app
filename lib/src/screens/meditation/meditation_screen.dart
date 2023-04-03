import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/models/favorite.dart';
import 'package:mental_health_app/src/models/meditation.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/services/db_service.dart';
import 'package:provider/provider.dart';

import '../../models/user_data.dart';
import '../components/audio.dart';
import '../components/audios.dart';
import '../player/player.dart';

class MeditationScreen extends StatelessWidget {
  late AuthProvider _auth;

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery
        .of(context)
        .size
        .height;
    var widthScreen = MediaQuery
        .of(context)
        .size
        .width;


    return SingleChildScrollView(
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: meditationPageUI(heightScreen, widthScreen),
      ),
    );
  }

  Widget meditationPageUI(double heightScreen, double widthScreen) {
    return Builder(builder: (BuildContext context) {
      _auth = Provider.of<AuthProvider>(context);
      return StreamBuilder<UserData>(
          stream: DBService.instance.getUserData(_auth.user!.uid),
          builder: (context, snapshot) {
            var userData = snapshot.data;
            return (userData == null)
                ? SizedBox(
              height: heightScreen / 2,
              child: SpinKitWanderingCubes(
                color: Colors.white,
                size: 50,
              ),
            )
                : Column(
              children: [
                Container(
                  height: heightScreen * 0.33,
                  padding: EdgeInsets.only(
                      right: tDefaultSizeM,
                      left: tDefaultSizeM,
                      bottom: tDefaultSizeL),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(tMeditationZoneImage),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tMeditationZoneTitle,
                        style: tsMeditationPageTitle,
                      ),
                      SizedBox(
                        height: tDefaultSizeS,
                      ),
                      Text(tMeditationZoneSubTitle,
                          style: tsMeditationPageSubTitle)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      right: tDefaultSizeM, left: tDefaultSizeM),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                      (userData.lastAudio == "") ? SizedBox() : StreamBuilder<Meditation>(
                        stream: DBService.instance.getAudio(userData.lastAudio),
                        builder: (context, snapshot) {
                          var aud = snapshot.data;
                          return (aud != null) ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tRecentlyPlayed, style: tsAudioGroupTitle),
                              SizedBox(
                                height: heightScreen * 0.02,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    height: 60,
                                    padding:
                                    EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: cItemColor,
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            10)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                (!aud
                                                    .premium)
                                                    ? IconButton(
                                                  icon: const Icon(
                                                    Icons
                                                        .play_circle,
                                                  ),
                                                  onPressed: () {
                                                    showGeneralDialog(
                                                        context: context,
                                                        barrierDismissible: true,
                                                        barrierLabel:
                                                        MaterialLocalizations
                                                            .of(
                                                            context)
                                                            .modalBarrierDismissLabel,
                                                        barrierColor: Colors
                                                            .black45,
                                                        pageBuilder: (
                                                            BuildContext ctx,
                                                            Animation animation,
                                                            Animation secondaryAnimation) {
                                                          return Container(
                                                              width: widthScreen,
                                                              height: heightScreen,
                                                              color: cBackgroundColor,
                                                              child: Player(audioId: aud.id, user: userData,)
                                                          );
                                                        });
                                                  },
                                                  color: cIconColor,
                                                )
                                                    : (userData
                                                    .isPremium)
                                                    ? IconButton(
                                                  icon: const Icon(
                                                    Icons
                                                        .play_circle,
                                                  ),
                                                  onPressed: () {
                                                    showGeneralDialog(
                                                        context: context,
                                                        barrierDismissible: true,
                                                        barrierLabel:
                                                        MaterialLocalizations
                                                            .of(
                                                            context)
                                                            .modalBarrierDismissLabel,
                                                        barrierColor: Colors
                                                            .black45,
                                                        pageBuilder: (
                                                            BuildContext ctx,
                                                            Animation animation,
                                                            Animation secondaryAnimation) {
                                                          return Container(
                                                              width: widthScreen,
                                                              height: heightScreen,
                                                              color: cBackgroundColor,
                                                              child: Player(audioId: aud.id, user: userData,)
                                                          );
                                                        });
                                                  },
                                                  color: cIconColor,
                                                )
                                                    : IconButton(
                                                  icon: const Icon(
                                                    Icons.lock,
                                                  ),
                                                  onPressed: () {},
                                                  color: cIconColor,
                                                ),
                                                SizedBox(
                                                  width:
                                                  tDefaultSizeS,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                        aud
                                                            .title,
                                                        style: tsAudioTitle, overflow: TextOverflow.ellipsis,),
                                                    SizedBox(
                                                      height:
                                                      3,
                                                    ),
                                                    Text(
                                                        "${(aud
                                                            .duration /
                                                            60)
                                                            .round()}:${aud
                                                            .duration %
                                                            60}",
                                                        style: tsAudioSubTitle)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ) : SizedBox();
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: heightScreen * 0.03,
                          ),
                          Text(tAudioListForMeditation,
                              style: tsAudioGroupTitle),
                          SizedBox(
                            height: heightScreen * 0.02,
                          ),
                          StreamBuilder<List<Favorite>>(
                            stream: DBService.instance.getFavourites(
                                userData.id),
                            builder: (context1, snapshot1) {
                              var data1 = snapshot1.data;
                              return StreamBuilder<List<Meditation>>(
                                  stream: DBService.instance.getAudios(
                                      Category.meditation),
                                  builder: (context, snapshot) {
                                    var data = snapshot.data;
                                    return (data != null && data1 != null)
                                        ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                    height: 60,
                                                    padding:
                                                    EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: cItemColor,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            10)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                (!data[index]
                                                                    .premium)
                                                                    ? IconButton(
                                                                  icon: const Icon(
                                                                    Icons
                                                                        .play_circle,
                                                                  ),
                                                                  onPressed: () {
                                                                    showGeneralDialog(
                                                                        context: context,
                                                                        barrierDismissible: true,
                                                                        barrierLabel:
                                                                        MaterialLocalizations
                                                                            .of(
                                                                            context)
                                                                            .modalBarrierDismissLabel,
                                                                        barrierColor: Colors
                                                                            .black45,
                                                                        pageBuilder: (
                                                                            BuildContext ctx,
                                                                            Animation animation,
                                                                            Animation secondaryAnimation) {
                                                                          return Container(
                                                                              width: widthScreen,
                                                                              height: heightScreen,
                                                                              color: cBackgroundColor,
                                                                              child: Player(audioId: data[index].id, user: userData,)
                                                                          );
                                                                        });
                                                                  },
                                                                  color: cIconColor,
                                                                )
                                                                    : (userData
                                                                    .isPremium)
                                                                    ? IconButton(
                                                                  icon: const Icon(
                                                                    Icons
                                                                        .play_circle,
                                                                  ),
                                                                  onPressed: () {
                                                                    showGeneralDialog(
                                                                        context: context,
                                                                        barrierDismissible: true,
                                                                        barrierLabel:
                                                                        MaterialLocalizations
                                                                            .of(
                                                                            context)
                                                                            .modalBarrierDismissLabel,
                                                                        barrierColor: Colors
                                                                            .black45,
                                                                        pageBuilder: (
                                                                            BuildContext ctx,
                                                                            Animation animation,
                                                                            Animation secondaryAnimation) {
                                                                          return Container(
                                                                              width: widthScreen,
                                                                              height: heightScreen,
                                                                              color: cBackgroundColor,
                                                                              child: Player(audioId: data[index].id, user: userData,)
                                                                          );
                                                                        });
                                                                  },
                                                                  color: cIconColor,
                                                                )
                                                                    : IconButton(
                                                                  icon: const Icon(
                                                                    Icons.lock,
                                                                  ),
                                                                  onPressed: () {},
                                                                  color: cIconColor,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  tDefaultSizeS,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 220,
                                                                      child: Text(
                                                                          data[index]
                                                                              .title,
                                                                          style: tsAudioTitle, overflow: TextOverflow.ellipsis,),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                      3,
                                                                    ),
                                                                    Text(
                                                                        "${(data[index]
                                                                            .duration /
                                                                            60)
                                                                            .round()}:${data[index]
                                                                            .duration %
                                                                            60}",
                                                                        style: tsAudioSubTitle)
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            (!data[index]
                                                                .premium) ?
                                                            (data1
                                                                .where((
                                                                element) =>
                                                            element.a_id ==
                                                                data[index].id)
                                                                .isEmpty)
                                                                ? IconButton(
                                                              icon: const Icon(
                                                                  Icons
                                                                      .favorite_border),
                                                              onPressed:
                                                                  () {
                                                                DBService
                                                                    .instance
                                                                    .setFavourite(
                                                                    _auth.user!
                                                                        .uid,
                                                                    data[index]
                                                                        .id,
                                                                    data[index]
                                                                        .title,
                                                                    data[index]
                                                                        .duration,
                                                                    data[index]
                                                                        .premium,
                                                                    data[index]
                                                                        .image,
                                                                    data[index]
                                                                        .link,
                                                                    data[index]
                                                                        .category);
                                                              },
                                                              color:
                                                              cIconColor,
                                                            )
                                                                : IconButton(
                                                              icon: const Icon(
                                                                  Icons
                                                                      .favorite),
                                                              onPressed:
                                                                  () {
                                                                DBService
                                                                    .instance
                                                                    .removeFavouriteByAudioId(
                                                                    userData.id,
                                                                    data[index]
                                                                        .id);
                                                              },
                                                              color:
                                                              cIconColor,
                                                            ) : (userData
                                                                .isPremium)
                                                                ?
                                                            (data1
                                                                .where((
                                                                element) =>
                                                            element.a_id ==
                                                                data[index].id)
                                                                .isEmpty)
                                                                ? IconButton(
                                                              icon: const Icon(
                                                                  Icons
                                                                      .favorite_border),
                                                              onPressed:
                                                                  () {
                                                                DBService
                                                                    .instance
                                                                    .setFavourite(
                                                                    _auth.user!
                                                                        .uid,
                                                                    data[index]
                                                                        .id,
                                                                    data[index]
                                                                        .title,
                                                                    data[index]
                                                                        .duration,
                                                                    data[index]
                                                                        .premium,
                                                                    data[index]
                                                                        .image,
                                                                    data[index]
                                                                        .link,
                                                                    data[index]
                                                                        .category);
                                                              },
                                                              color:
                                                              cIconColor,
                                                            )
                                                                : IconButton(
                                                              icon: const Icon(
                                                                  Icons
                                                                      .favorite),
                                                              onPressed:
                                                                  () {
                                                                DBService
                                                                    .instance
                                                                    .removeFavouriteByAudioId(
                                                                    userData.id,
                                                                    data[index]
                                                                        .id);
                                                              },
                                                              color:
                                                              cIconColor,
                                                            )
                                                                : const SizedBox(),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(
                                                height: tDefaultSizeS,
                                              )
                                            ],
                                          );
                                        })
                                        : const SpinKitWanderingCubes(
                                      color: Colors.white,
                                      size: 50,
                                    );
                                  });
                            },
                          ),

                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          });
    });
  }
}
