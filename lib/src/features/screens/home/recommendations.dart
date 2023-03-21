import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({Key? key}) : super(key: key);
  static const List recommendations = [["Алиса в стране чудес" , tHomePageRec], ["Какаши Хатаке" , tHomePageRec], ["Сакура Харуна" , tHomePageRec]];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            final item = recommendations[index];
            return Container(
              padding: EdgeInsets.only(bottom: tDefaultSizeS),
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(item[1]), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(tDefaultSizeS)
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 12,
                    width: 114,
                    decoration: BoxDecoration(
                      color: cTextColor,
                      borderRadius: BorderRadius.all(Radius.circular(tDefaultSizeS)),
                    ),
                    child: Text(item[0], style: tsHomePageItemSubTitle, textAlign: TextAlign.center,)),
              ),
            );
          }, separatorBuilder: (context, index) => SizedBox(width: tDefaultSizeS,),
      ),
    );
  }
}


class Recommendation {
  String name;
  String img;

  Recommendation(this.name, this.img);

  @override
  String toString() {
    return '{ ${this.name}, ${this.img} }';
  }

  String get getName {
    return this.name;
  }

  String get getImg {
    return this.img;
  }
}
