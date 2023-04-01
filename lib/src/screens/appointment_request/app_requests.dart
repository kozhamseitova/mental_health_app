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

    Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cItemColor,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(image: AssetImage(tDialogImg)),
              Container(
                padding: EdgeInsets.all(tDefaultSizeM),
                child: Column(
                  children: [
                    Text(tDialog),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: tPhone,
                        hintText: tPhone,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.grey),
                        ),),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: tProblem,
                        hintText: tProblem,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.grey),
                        ),),
                    ),
                    SizedBox(height: tDefaultSizeS,),
                    TextButton(
                      onPressed: () {},
                      child: Text(tApply, style: tsApply,),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(width: 1, color: cIconColor),
                          ),
                        ),
                      ),),
                  ],
                ),
              )
            ],
          ),

        ));




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
                              onPressed: () { openDialog(); },
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
