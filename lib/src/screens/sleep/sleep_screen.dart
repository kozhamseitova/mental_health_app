import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/models/favorite.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/screens/sleep/stories.dart';
import 'package:mental_health_app/src/services/db_service.dart';
import 'package:provider/provider.dart';

import '../../models/meditation.dart';
import '../../models/user_data.dart';
import '../components/audios.dart';
import '../player/player.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: sleepPageUI(heightScreen, widthScreen),
      ),
    );
  }

  void showPremiumBanner() {}

  Widget sleepPageUI(double heightScreen, double widthScreen) {
    return Builder(builder: (BuildContext context) {
      var _auth = Provider.of<AuthProvider>(context);
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
                            image: AssetImage(tSleepZoneImage),
                            fit: BoxFit.fill),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData.lang == "rus" ? tSleepZoneTitle : tSleepZoneTitleQaz,
                            style: tsMeditationPageTitle,
                          ),
                          SizedBox(
                            height: tDefaultSizeS,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image(
                                image: AssetImage(tSleepZoneIcon),
                                height: heightScreen * 0.15,
                              ),
                              Text(
                                  userData.lang == "rus" ? tSleepZoneSubTitle : tSleepZoneSubTitleQaz,
                                  style: tsMeditationPageSubTitle)
                            ],
                          )
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  userData.lang == "rus" ? tBedTimeStories : tBedTimeStoriesQaz,
                                  style: tsAudioGroupTitle),
                              SizedBox(
                                height: heightScreen * 0.02,
                              ),
                              StreamBuilder<List<Meditation>>(
                                stream: DBService.instance
                                    .getAudios(Category.story),
                                builder: (context, snapshot) {
                                  var data = snapshot.data;
                                  return (data == null)
                                      ? const SpinKitWanderingCubes(
                                          color: Colors.white,
                                          size: 50,
                                        )
                                      : SizedBox(
                                          height: 150,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  showGeneralDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      barrierLabel:
                                                          MaterialLocalizations
                                                                  .of(context)
                                                              .modalBarrierDismissLabel,
                                                      barrierColor:
                                                          Colors.black45,
                                                      pageBuilder: (BuildContext
                                                              ctx,
                                                          Animation animation,
                                                          Animation
                                                              secondaryAnimation) {
                                                        return Container(
                                                            width: widthScreen,
                                                            height:
                                                                heightScreen,
                                                            color:
                                                                cBackgroundColor,
                                                            child: Player(
                                                              audioId:
                                                                  data[index]
                                                                      .id,
                                                              user: userData,
                                                            ));
                                                      });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      tDefaultSizeS),
                                                  decoration: BoxDecoration(
                                                      color: cItemColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  height: 150,
                                                  width: 150,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 130,
                                                        child: Text(
                                                          userData.lang == "rus" ? data[index].title : data[index].titleQaz,
                                                          style: tsStoryTitle,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${(data[index].duration / 60).round().toString()} минут",
                                                        style: tsStorySubTitle,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                tStoryImage),
                                                            height: 90,
                                                            alignment: Alignment
                                                                .center,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              width: tDefaultSizeS,
                                            ),
                                          ));
                                },
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: heightScreen * 0.03,
                              ),
                              Text(
                                  userData.lang == "rus" ? tAudioListForSleep : tAudioListForSleepQaz,
                                  style: tsAudioGroupTitle),
                              SizedBox(
                                height: heightScreen * 0.02,
                              ),
                              StreamBuilder<List<Favorite>>(
                                stream: DBService.instance
                                    .getFavourites(userData.id),
                                builder: (context1, snapshot1) {
                                  var data1 = snapshot1.data;
                                  return StreamBuilder<List<Meditation>>(
                                    stream: DBService.instance
                                        .getAudios(Category.sleep),
                                    builder: (context, snapshot) {
                                      var data = snapshot.data;
                                      return (data != null && data1 != null)
                                          ? ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Container(
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
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.play_circle,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              showGeneralDialog(
                                                                                  context: context,
                                                                                  barrierDismissible: true,
                                                                                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                                  barrierColor: Colors.black45,
                                                                                  pageBuilder: (BuildContext ctx, Animation animation, Animation secondaryAnimation) {
                                                                                    return Container(
                                                                                        width: widthScreen,
                                                                                        height: heightScreen,
                                                                                        color: cBackgroundColor,
                                                                                        child: Player(
                                                                                          audioId: data[index].id,
                                                                                          user: userData,
                                                                                        ));
                                                                                  });
                                                                            },
                                                                            color:
                                                                                cIconColor,
                                                                          )
                                                                        : (userData.isPremium)
                                                                            ? IconButton(
                                                                                icon: const Icon(
                                                                                  Icons.play_circle,
                                                                                ),
                                                                                onPressed: () {
                                                                                  showGeneralDialog(
                                                                                      context: context,
                                                                                      barrierDismissible: true,
                                                                                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                                      barrierColor: Colors.black45,
                                                                                      pageBuilder: (BuildContext ctx, Animation animation, Animation secondaryAnimation) {
                                                                                        return Container(
                                                                                            width: widthScreen,
                                                                                            height: heightScreen,
                                                                                            color: cBackgroundColor,
                                                                                            child: Player(
                                                                                              audioId: data[index].id,
                                                                                              user: userData,
                                                                                            ));
                                                                                      });
                                                                                },
                                                                                color: cIconColor,
                                                                              )
                                                                            : IconButton(
                                                                                icon: const Icon(
                                                                                  Icons.lock,
                                                                                ),
                                                                                onPressed: () {
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: (context) => AlertDialog(
                                                                                          backgroundColor: cItemColor,
                                                                                          contentPadding: EdgeInsets.zero,
                                                                                          content: Container(
                                                                                            padding: EdgeInsets.all(tDefaultSizeML),
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(tDefaultSizeS), color: cItemColor),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              children: [
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                                  children: [
                                                                                                    IconButton(
                                                                                                      icon: Icon(
                                                                                                        Icons.close_rounded,
                                                                                                        color: cSubTextColor,
                                                                                                      ),
                                                                                                      onPressed: () {
                                                                                                        Navigator.of(context).pop();
                                                                                                      },
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Image(image: AssetImage(tPremiumImg)),
                                                                                                Column(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      userData.lang == "rus" ? tPremiumTitle2 : tPremiumTitle2Qaz,
                                                                                                      style: tsPremiumTitle,
                                                                                                      textAlign: TextAlign.center,
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: tDefaultSizeS,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      userData.lang  == "rus" ? tPremiumSubTitle2 : tPremiumSubTitle2Qaz,
                                                                                                      style: tsPremiumSubTitle,
                                                                                                      textAlign: TextAlign.center,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Column(
                                                                                                  children: [
                                                                                                    Container(
                                                                                                        child: Text(
                                                                                                          userData.lang  == "rus" ? "Всего за 1390тг" : "Бар болғаны 1390 теңге",
                                                                                                      style: tsCostWhite,
                                                                                                    )),
                                                                                                    Container(
                                                                                                        transform: Matrix4.translationValues(0.0, -43.0, 0.0),
                                                                                                        child: Text(
                                                                                                          userData.lang  == "rus" ? "Всего за 1390тг" : "Бар болғаны 1390 теңге",
                                                                                                          style: tsCost,
                                                                                                        )),
                                                                                                  ],
                                                                                                ),
                                                                                                ElevatedButton(
                                                                                                    style: ButtonStyle(
                                                                                                      minimumSize: MaterialStateProperty.all(Size(150, 50)),
                                                                                                      backgroundColor: MaterialStateProperty.all(cAppRequestPageTitle),
                                                                                                      shape: MaterialStateProperty.all(
                                                                                                        RoundedRectangleBorder(
                                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    onPressed: () {
                                                                                                      DBService.instance.setPremium(userData.id);
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      userData.lang == "rus" ? tPremiumButton : tPremiumButtonQaz,
                                                                                                      style: tsButton,
                                                                                                    )),
                                                                                                SizedBox(
                                                                                                  height: tDefaultSizeS,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          )));
                                                                                },
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
                                                                            userData.lang == "rus" ? data[index]
                                                                                .title : data[index].titleQaz,
                                                                            style:
                                                                                tsAudioTitle),
                                                                        SizedBox(
                                                                          height:
                                                                              3,
                                                                        ),
                                                                        Text(
                                                                            "${(data[index].duration / 60).round()}:${data[index].duration % 60}",
                                                                            style:
                                                                                tsAudioSubTitle)
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                (!data[index]
                                                                        .premium)
                                                                    ? (data1
                                                                            .where((element) =>
                                                                                element.a_id ==
                                                                                data[index].id)
                                                                            .isEmpty)
                                                                        ? IconButton(
                                                                            icon:
                                                                                const Icon(Icons.favorite_border),
                                                                            onPressed:
                                                                                () {
                                                                              DBService.instance.setFavourite(_auth.user!.uid, data[index].id, data[index].title, data[index].titleQaz, data[index].duration, data[index].premium, data[index].image, data[index].link, data[index].category);
                                                                            },
                                                                            color:
                                                                                cIconColor,
                                                                          )
                                                                        : IconButton(
                                                                            icon:
                                                                                const Icon(Icons.favorite),
                                                                            onPressed:
                                                                                () {
                                                                              DBService.instance.removeFavouriteByAudioId(userData.id, data[index].id);
                                                                            },
                                                                            color:
                                                                                cIconColor,
                                                                          )
                                                                    : (userData.isPremium)
                                                                        ? (data1.where((element) => element.a_id == data[index].id).isEmpty)
                                                                            ? IconButton(
                                                                                icon: const Icon(Icons.favorite_border),
                                                                                onPressed: () {
                                                                                  DBService.instance.setFavourite(_auth.user!.uid, data[index].id, data[index].title, data[index].titleQaz, data[index].duration, data[index].premium, data[index].image, data[index].link, data[index].category);
                                                                                },
                                                                                color: cIconColor,
                                                                              )
                                                                            : IconButton(
                                                                                icon: const Icon(Icons.favorite),
                                                                                onPressed: () {
                                                                                  DBService.instance.removeFavouriteByAudioId(userData.id, data[index].id);
                                                                                },
                                                                                color: cIconColor,
                                                                              )
                                                                        : const SizedBox()
                                                              ],
                                                            ),
                                                          ],
                                                        )),
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
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
        },
      );
    });
  }
}
