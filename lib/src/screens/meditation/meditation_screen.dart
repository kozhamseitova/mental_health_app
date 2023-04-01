import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/models/meditation.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/services/db_service.dart';
import 'package:provider/provider.dart';

import '../../models/user_data.dart';
import '../components/audio.dart';
import '../components/audios.dart';

class MeditationScreen extends StatelessWidget {
  late AuthProvider _auth;

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: meditationPageUI(heightScreen),
      ),
    );
  }

  Widget meditationPageUI(double heightScreen) {
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tRecentlyPlayed, style: tsAudioGroupTitle),
                                SizedBox(
                                  height: heightScreen * 0.02,
                                ),
                                AudioItem(),
                                SizedBox(
                                  height: heightScreen * 0.01,
                                ),
                                AudioItem()
                              ],
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
                                StreamBuilder<List<Meditation>>(
                                    stream: DBService.instance.getAudios(Category.meditation),
                                    builder: (context, snapshot) {
                                      var data = snapshot.data;
                                      print(userData.isPremium);
                                      return (data != null)
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        DBService.instance
                                                            .getUserData(_auth
                                                                .user!.uid);
                                                      },
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
                                                                                Icons.play_circle,
                                                                              ),
                                                                              onPressed: () {},
                                                                              color: cIconColor,
                                                                            )
                                                                          : (userData.isPremium)
                                                                              ? IconButton(
                                                                                  icon: const Icon(
                                                                                    Icons.play_circle,
                                                                                  ),
                                                                                  onPressed: () {},
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
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              data[index].title,
                                                                              style: tsAudioTitle),
                                                                          SizedBox(
                                                                            height:
                                                                                3,
                                                                          ),
                                                                          Text(
                                                                              "${(data[index].duration / 60).round()}:${data[index].duration % 60}",
                                                                              style: tsAudioSubTitle)
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  (!data[index]
                                                                      .premium) ?
                                                                  IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .favorite_border),
                                                                    onPressed:
                                                                        () {},
                                                                    color:
                                                                        cIconColor,
                                                                  ) : (userData.isPremium) ?
                                                                  IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .favorite_border),
                                                                    onPressed:
                                                                        () {},
                                                                    color:
                                                                    cIconColor,
                                                                  ) : const SizedBox(),
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
                                    }),
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
