
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/features/screens/profile/doctorRequests.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../../../constants/text_styles.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);


  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  Color incomingColor = primary;
  var acceptedColor = cBackgroundColor;
  String request = "Входящий";
  static const String name = "Маха";
  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: widthScreen * 0.05, right: widthScreen * 0.05),
      child: Column(
        children: [
          SizedBox(height: tDefaultSizeL,),
          Row(
            children: [Text(tHelloDoctor + name + "!", style: tsProfilePageTitle)],
          ),
          SizedBox(height: tDefaultSizeL,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Image(image: AssetImage(tDoctorProfileImage), height: heightScreen*0.22,)],
          ),
          SizedBox(height: tDefaultSizeL,),
          Row(children: [Text(tRequests, style: tsProfilePageSubTitle,)],),
          SizedBox(height: tDefaultSizeS,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: incomingColor,
                            width: 2
                        )
                    )
                ),
                child:
                TextButton(onPressed: () {
                  setState(() {
                    incomingColor = primary;
                    acceptedColor = cBackgroundColor;
                    request = "Входящий";
                  });
                  },
                child: Text(tIncoming, style: tsRequestGroupTitle,)),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: acceptedColor,
                            width: 2
                        )
                    )
                ),
                child:
                TextButton(onPressed: () {
                  setState(() {
                    incomingColor = cBackgroundColor;
                    acceptedColor = primary;
                    request = "Принят";
                  });
                  },
                child: Text(tAccepted, style: tsRequestGroupTitle,)),
              )
            ],
          ),
          SizedBox(height: tDefaultSizeS,),
          DoctorRequests(request: request,),
        ],
      ),
    );
  }
}
