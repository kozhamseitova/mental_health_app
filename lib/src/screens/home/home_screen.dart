import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/screens/home/recommendations.dart';

import '../../constants/image_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String name = "Маха";
  static const String minutesOfMeditation = "5";

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;

    return Container(
      height: heightScreen,
      width: widthScreen,
      padding: EdgeInsets.only(top: widthScreen * 0.1, right: widthScreen * 0.03, left: widthScreen * 0.03),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(tWelcomePageImage), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
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
                      tHomePageSubTitle,
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
                        borderRadius: BorderRadius.circular(tDefaultSizeS)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          minutesOfMeditation + tMeditationTimeTitle,
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
                      child: Text(tPopularAudio, style: tsHomePageItemTitle),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            tPremiumTitle,
                            style: tsHomePageItemTitle,
                          ),
                          Text(tPremiumSubTitle, style: tsHomePageItemSubTitle)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
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
                Stack(
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
                        "13 минут",
                        style: tsHomePageDailyMeditationSubTitle,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(
              tRecommendationTitle,
              style: tsHomePageTitle,
            ),
            SizedBox(height: tDefaultSizeM,),
            Recommendations()
          ],
        ),
      ),
    );
  }
}
