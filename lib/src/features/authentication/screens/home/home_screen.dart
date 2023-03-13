import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/features/authentication/screens/home/recommendations.dart';

import '../../../../constants/image_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String name = "Маха";
  static const String minutesOfMeditation = "5";

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Container(
          height: heightScreen,
          decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(tWelcomePageImage), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          tHomePageTitle,
                          style: tsHomePageTitle,
                        ),
                        Text(
                          name,
                          style: tsHomePageTitle,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          tHomePageSubTitle,
                          style: tsHomePageSubTitle,
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 141,
                      height: 224,
                        padding: EdgeInsets.only(top: tDefaultSizeS, left: tDefaultSizeS),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(tHomePageMeditation),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(minutesOfMeditation + tMeditationTimeTitle, style: tsHomePageMeditationTitle,),
                          Text(tMeditationTimeSubTitle, style: tsHomePageMeditationSubTitle,)
                        ],
                      )
                    ),
                    Column(
                      children: [
                        Container(
                          width: 188,
                          height: 139,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(tHomePageAudio),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          width: 188,
                          height: 76,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(tHomePagePremium),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      tDailyMeditationTitle,
                      style: tsHomePageTitle,
                    ),
                    Container(
                      width: 350,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(tHomePageDailyAudio),
                        ),
                      ),
                    ),
                  ],
                ),
                Recommendations()
              ],
            )
          ),
      )),
    );
  }
}
