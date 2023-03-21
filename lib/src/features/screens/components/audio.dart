import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';

import '../../../constants/text_styles.dart';

class AudioItem extends StatefulWidget {
  const AudioItem({Key? key}) : super(key: key);

  @override
  State<AudioItem> createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {  },
                  color: cIconColor,
                ),
              ],
            ),
          ],
        )
    );
  }
}

