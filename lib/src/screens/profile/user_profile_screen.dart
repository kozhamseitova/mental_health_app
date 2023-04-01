import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/features/auth.dart';
import 'package:mental_health_app/src/screens/profile/requests.dart';
import 'package:mental_health_app/src/services/db_service.dart';

import '../../constants/text_strings.dart';
import '../../models/user_data.dart';
import '../components/audios.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  static const String name = "Маха";
  static const String minutes = "0";
  static const String sessions = "0";

  late AuthProvider _auth;

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    var heightScreen = MediaQuery
        .of(context)
        .size
        .height;
    return SingleChildScrollView(
        padding: EdgeInsets.only(
            left: widthScreen * 0.05, right: widthScreen * 0.05),
        child: ChangeNotifierProvider<AuthProvider>.value(
            value: AuthProvider.instance,
            child: _profilePageUI(heightScreen, widthScreen)));
  }

  Widget _profilePageUI(double heightScreen, double widthScreen) {
    return Builder(builder: (BuildContext context) {
      _auth = Provider.of<AuthProvider>(context);
      return StreamBuilder<UserData>(
          stream: DBService.instance.getUserData(_auth.user!.uid),
          builder: (context, snapshot) {
            var userData = snapshot.data;
            return (userData == null) ? SizedBox(height: heightScreen/2, child: SpinKitWanderingCubes(color: Colors.white, size: 50,),) : Column(
              children: [
                SizedBox(
                  height: tDefaultSizeL,
                ),
                Column(
                  children: [
                    Image(
                      image: AssetImage(tUserProfileImage),
                      height: heightScreen * 0.22,
                    ),
                    Text(tHello + userData!.name + "!", style: tsProfilePageTitle),
                  ],
                ),
                SizedBox(
                  height: tDefaultSizeL,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: heightScreen * 0.23,
                      width: heightScreen * 0.23 * 0.85,
                      padding: EdgeInsets.all(tDefaultSizeM),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(tUserProfileListened),
                              fit: BoxFit.fill)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tListened, style: tsProfilePageContainerText),
                          Text(
                            minutes + tMinutes,
                            style: tsProfilePageContainerText,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: heightScreen * 0.23,
                      width: heightScreen * 0.23 * 0.85,
                      padding: EdgeInsets.all(tDefaultSizeM),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(tUserProfileFinished),
                              fit: BoxFit.fill)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tFinished, style: tsProfilePageContainerText),
                          Text(
                            sessions + tSessions,
                            style: tsProfilePageContainerText,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: tDefaultSizeL,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tRequests, style: tsProfilePageSubTitle),
                    SizedBox(
                      height: tDefaultSizeM,
                    ),
                    Requests(),
                  ],
                ),
                SizedBox(
                  height: tDefaultSizeM,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tFavourites, style: tsProfilePageSubTitle),
                    SizedBox(
                      height: tDefaultSizeM,
                    ),
                    AudioItems(),
                  ],
                ),
              ],
            );
          });
    });
  }
}
