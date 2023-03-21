import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/features/screens/appointment_request/app_requests.dart';

import '../../../constants/sizes.dart';

class AppointmentRequestScreen extends StatelessWidget {
  const AppointmentRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: widthScreen * 0.05, right: widthScreen * 0.05),
            height: heightScreen * 0.33,
            color: cItemColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(tAppointmentRequestTitle, style: tsAppRequestPageTitle),
                Text(tAppointmentRequestSubTitle, style: tsAppRequestPageSubTitle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Image(image: AssetImage(tAppRequestPageImage), height: heightScreen * 0.2,)],
                )
              ],
            ),
          ),
          SizedBox(height: heightScreen * 0.03,),
          Container(
            padding: EdgeInsets.only(left: widthScreen * 0.05, right: widthScreen * 0.05),
            child: AppRequests(),
          )
        ],
      ),
    );
  }
}
