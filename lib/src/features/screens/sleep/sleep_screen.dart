import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/features/screens/components/audio.dart';
import 'package:mental_health_app/src/features/screens/components/audios.dart';
import 'package:mental_health_app/src/features/screens/home/recommendations.dart';
import 'package:mental_health_app/src/features/screens/sleep/stories.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var heightScreen = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: heightScreen * 0.33,
            padding: EdgeInsets.only(right: tDefaultSizeM, left: tDefaultSizeM, bottom: tDefaultSizeL),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(tSleepZoneImage),
                  fit: BoxFit.fill
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tSleepZoneTitle, style: tsMeditationPageTitle,),
                SizedBox(
                  height: tDefaultSizeS,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(image: AssetImage(tSleepZoneIcon),
                    height: heightScreen * 0.17,),
                    SizedBox(width: 10,),
                    Text(tSleepZoneSubTitle, style: tsMeditationPageSubTitle)
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: tDefaultSizeM, left: tDefaultSizeM),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: heightScreen * 0.03,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tBedTimeStories, style: tsAudioGroupTitle),
                    SizedBox(height: heightScreen * 0.02,),
                    Stories()
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: heightScreen * 0.03,),
                    Text(tAudioListForSleep, style: tsAudioGroupTitle),
                    SizedBox(height: heightScreen * 0.02,),
                    AudioItems(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
