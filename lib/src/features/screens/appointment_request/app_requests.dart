import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';

class AppRequests extends StatelessWidget {
  const AppRequests({Key? key}) : super(key: key);
  static const List doctors = [["Елена" , "3 года опыта"], ["Елена" , "3 года опыта"]];

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;

    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            final item = doctors[index];
            return Column(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(tDefaultSizeS),
                    border: Border.all(
                      color: cIconColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image: AssetImage(tDoctor), height: 90,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item[0], style: tsRequestTitle,),
                              Text(item[1], style: tsStorySubTitle,)
                            ],
                          ),
                          Container(
                            width: widthScreen * 0.5,
                            child: TextButton(
                              onPressed: () { },
                              child: Text(tApply, style: tsApply,),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(width: 1, color: cIconColor),
                                  ),
                                ),
                            ),),
                          )
                        ],
                      )
                    ],
                  )
                ),
                SizedBox(height: tDefaultSizeS,),
              ],
            );
          }
      ),
    );
  }
}
