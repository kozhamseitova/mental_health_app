import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';

class Stories extends StatelessWidget {
  const Stories({Key? key}) : super(key: key);
  static const List stories = [["Алиса в стране чудес" , "11 минут", tStoryImage], ["Какаши Хатаке" , "11 минут", tStoryImage], ["Сакура Харуна" , "11 минут", tStoryImage]];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final item = stories[index];
          return Container(
            padding: EdgeInsets.all(tDefaultSizeS),
            decoration: BoxDecoration(
              color: cItemColor,
              borderRadius: BorderRadius.circular(10)
            ),
            height: 150,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item[0], style: tsStoryTitle,),
                Text(item[1], style: tsStorySubTitle,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(item[2]),
                      height: 90, alignment: Alignment.center,)
                  ],
                )
              ],
            ),
          );
        }, separatorBuilder: (context, index) => SizedBox(width: tDefaultSizeS,),
      ),
    );
  }
}


