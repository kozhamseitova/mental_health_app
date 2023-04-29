import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/services/db_service.dart';
import 'package:provider/provider.dart';

import '../../constants/sizes.dart';
import '../../models/user_data.dart';

class AppointmentRequestScreen extends StatelessWidget {
  AppointmentRequestScreen({Key? key}) : super(key: key);

  final TextEditingController _controllerContact = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: ChangeNotifierProvider<AuthProvider>.value(
      value: AuthProvider.instance,
      child: appointmentPageUI(heightScreen, widthScreen),
    ));
  }

  Widget appointmentPageUI(double heightScreen, double widthScreen) {
    return Builder(builder: (BuildContext context) {
      var _auth = Provider.of<AuthProvider>(context);
      Random rnd;
      return StreamBuilder<UserData>(
        stream: DBService.instance.getUserData(_auth.user!.uid),
        builder: (context, snapshot) {
          var userData = snapshot.data;
          return (userData == null)
              ? SizedBox(
                  height: heightScreen / 2,
                  child: SpinKitWanderingCubes(
                    color: Colors.white,
                    size: 50,
                  ),
                )
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: widthScreen * 0.05, right: widthScreen * 0.05),
                      height: heightScreen * 0.33,
                      color: cItemColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              userData.lang == "rus" ? tAppointmentRequestTitle : tAppointmentRequestTitleQaz,
                              style: tsAppRequestPageTitle),
                          Text(
                              userData.lang == "rus" ? tAppointmentRequestSubTitle : tAppointmentRequestSubTitleQaz,
                              style: tsAppRequestPageSubTitle),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image(
                                image: AssetImage(tAppRequestPageImage),
                                height: heightScreen * 0.2,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.03,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: widthScreen * 0.05, right: widthScreen * 0.05),
                      child: StreamBuilder<List<UserData>>(
                        stream: DBService.instance.getUsers("psychologist"),
                        builder: (context, snapshot) {
                          var data = snapshot.data;
                          print(data);
                          return (data != null) ?  ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {

                                final item = data[index];
                                String expWord;
                                if (userData.lang == "rus") {
                                  expWord = "лет";
                                  if ((item.exp % 10 == 1) &&
                                      (item.exp != 11)) {
                                    expWord = "год";
                                  } else if ((item.exp % 10 > 1) &&
                                      (item.exp % 10 < 5) && (item.exp != 12) &&
                                      (item.exp != 13) && item.exp != 14) {
                                    expWord = "года";
                                  }
                                } else {
                                  expWord = "жыл";
                                }

                                rnd = new Random();
                                int r = 1 + rnd.nextInt(8 - 1);
                                print(r);

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
                                            Image(image: AssetImage("assets/images/appointment_request_page/doctor${r.toString()}.png"), height: 90,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(item.name, style: tsRequestTitle,),
                                                    Text("${userData.lang == "rus" ? "Стаж": "Тәжірибе"} ${item.exp} $expWord", style: tsStorySubTitle,)
                                                  ],
                                                ),
                                                Container(
                                                  width: widthScreen * 0.5,
                                                  child: TextButton(
                                                    onPressed: () {

                                                     showDialog(
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
                                                                      Text(userData.lang == "rus" ? tDialog : tDialogQaz),
                                                                      TextFormField(
                                                                        controller: _controllerContact,
                                                                        decoration: const InputDecoration(
                                                                          labelText: tPhone,
                                                                          hintText: tPhone,
                                                                          enabledBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(width: 1.0, color: Colors.grey),
                                                                          ),),
                                                                      ),
                                                                      TextFormField(
                                                                        controller: _controllerDesc,
                                                                        decoration:  InputDecoration(
                                                                          labelText: userData.lang == "rus" ? tProblem : tProblemQaz,
                                                                          hintText: userData.lang == "rus" ? tProblem : tProblemQaz,
                                                                          enabledBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(width: 1.0, color: Colors.grey),
                                                                          ),),
                                                                      ),
                                                                      SizedBox(height: tDefaultSizeS,),
                                                                      TextButton(
                                                                        onPressed: () {

                                                                          DBService.instance.sendRequest(
                                                                              item.id,
                                                                              _auth.user!.uid,
                                                                              item.name,
                                                                              userData.name,
                                                                              _controllerContact.text,
                                                                              _controllerDesc.text,
                                                                          );

                                                                          Navigator.of(context).pop();


                                                                        },
                                                                        child: Text(userData.lang  == "rus" ? tApply : tApplyQaz, style: tsApply,),
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


                                                    },
                                                    child: Text(userData.lang == "rus" ? tApply : tApplyQaz, style: tsApply,),
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
                          ) : const SpinKitWanderingCubes(
                            color: Colors.white,
                            size: 50,
                          );
                        },
                      ),
                    )
                  ],
                );
        },
      );
    });
  }
}
