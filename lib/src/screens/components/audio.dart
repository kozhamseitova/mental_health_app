import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_styles.dart';


class AudioItem extends StatefulWidget {
  const AudioItem({Key? key}) : super(key: key);

  @override
  State<AudioItem> createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {

  @override
  Widget build(BuildContext context) {

    Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: cItemColor,
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.all(tDefaultSizeML),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(tDefaultSizeS),
                  color: cItemColor
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.close_rounded, color: cSubTextColor,),
                    ],
                  ),
                  Image(image: AssetImage(tPremiumImg)),
                  Column(
                    children: [
                      Text(tPremiumTitle2, style: tsPremiumTitle, textAlign: TextAlign.center,),
                      SizedBox(height: tDefaultSizeS,),
                      Text(tPremiumSubTitle2, style: tsPremiumSubTitle,textAlign: TextAlign.center,),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          child: Text("Всего за 1390тг", style: tsCostWhite,)),
                      Container(
                          transform: Matrix4.translationValues(0.0, -43.0, 0.0),
                          child: Text("Всего за 1390тг", style: tsCost,)),
                    ],
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                        MaterialStateProperty.all(Size(150, 50)),
                        backgroundColor:
                        MaterialStateProperty.all(cAppRequestPageTitle),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: ()  {},
                      child: Text(
                        tPremiumButton,
                        style: tsButton,
                      )),
                  SizedBox(height: tDefaultSizeS,),
                ],
              ),
            )
        ));





    return Container(
        height: 60,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: cItemColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_circle,),
                      onPressed: () {  },
                      color: cIconColor,
                    ),
                    SizedBox(
                      width: tDefaultSizeS,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tAudioListForMeditation, style: tsAudioTitle),
                        SizedBox(height: 3,),
                        Text("15:08", style: tsAudioSubTitle )
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () { openDialog(); },
                  color: cIconColor,
                ),
              ],
            ),
          ],
        )
    );
  }
}

