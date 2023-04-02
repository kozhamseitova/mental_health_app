import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health_app/src/models/request.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/services/db_service.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../constants/text_styles.dart';
import '../../models/user_data.dart';
import 'doctorRequests.dart';

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
        padding: EdgeInsets.only(
            left: widthScreen * 0.05, right: widthScreen * 0.05),
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: profilePageUI(heightScreen, widthScreen),
        ));
  }

  Widget profilePageUI(double heightScreen, double widthScreen) {
    return Builder(builder: (BuildContext context) {
      var _auth = Provider.of<AuthProvider>(context);
      return StreamBuilder<UserData>(
        stream: DBService.instance.getUserData(_auth.user!.uid),
        builder: (context, snapshot) {
          var userData = snapshot.data;
          return (userData != null)
              ? Column(
                  children: [
                    SizedBox(
                      height: tDefaultSizeL,
                    ),
                    Row(
                      children: [
                        Text(tHelloDoctor + userData.name + "!",
                            style: tsProfilePageTitle)
                      ],
                    ),
                    SizedBox(
                      height: tDefaultSizeL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                          image: AssetImage(tDoctorProfileImage),
                          height: heightScreen * 0.22,
                        )
                      ],
                    ),
                    SizedBox(
                      height: tDefaultSizeL,
                    ),
                    Row(
                      children: [
                        Text(
                          tRequests,
                          style: tsProfilePageSubTitle,
                        )
                      ],
                    ),
                    SizedBox(
                      height: tDefaultSizeS,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: incomingColor, width: 2))),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  incomingColor = primary;
                                  acceptedColor = cBackgroundColor;
                                  request = "Входящий";
                                });
                              },
                              child: Text(
                                tIncoming,
                                style: tsRequestGroupTitle,
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: acceptedColor, width: 2))),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  incomingColor = cBackgroundColor;
                                  acceptedColor = primary;
                                  request = "Принят";
                                });
                              },
                              child: Text(
                                tAccepted,
                                style: tsRequestGroupTitle,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: tDefaultSizeS,
                    ),
                    StreamBuilder<List<AppointmentRequest>>(
                      stream: DBService.instance
                          .getRequests(userData.id, userData.role, "отправлено"),
                      builder: (context1, snapshot1) {
                        var sended = snapshot1.data;
                        return StreamBuilder<List<AppointmentRequest>>(
                          stream: DBService.instance
                              .getRequests(userData.id, userData.role, "принято"),
                          builder: (context2, snapshot2) {
                            var accepted = snapshot2.data;
                            return (sended != null && accepted != null)
                                ? (request == "Входящий") ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: sended.length,
                                    itemBuilder: (context, index) {
                                      final item = sended[index];
                                      return Column(
                                        children: [
                                          Container(
                                            height: 90,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      tDefaultSizeS),
                                              border: Border.all(
                                                color: cIconColor,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${sended[index].fromName}   ${sended[index].contact}",
                                                          style: tsRequestTitle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                            width: widthScreen *
                                                                0.55,
                                                            child: Text(
                                                              sended[index]
                                                                  .description,
                                                              style:
                                                                  tsRequestSubTitle,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 3,
                                                            ))
                                                      ],
                                                    ),
                                                    request == "Входящий"
                                                        ? Row(
                                                            children: [
                                                              IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons.check,
                                                                ),
                                                                onPressed:
                                                                    () {

                                                                        DBService.instance.updateRequest(item.id, "принято");

                                                                    },
                                                                color:
                                                                    cIconColor,
                                                              ),
                                                              IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .not_interested,
                                                                ),
                                                                onPressed:
                                                                    () {

                                                                      DBService.instance.updateRequest(item.id, "отказано");


                                                                    },
                                                                color:
                                                                    cIconColor,
                                                              ),
                                                            ],
                                                          )
                                                        : Text(
                                                            "DEDE",
                                                            style:
                                                                tsRequestAccepted,
                                                          )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: tDefaultSizeS,
                                          ),
                                        ],
                                      );
                                    })
                                : ListView.builder(
                                shrinkWrap: true,
                                itemCount: accepted.length,
                                itemBuilder: (context, index) {
                                  final item = accepted[index];
                                  return Column(
                                    children: [
                                      Container(
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              tDefaultSizeS),
                                          border: Border.all(
                                            color: cIconColor,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "${item.fromName}   ${item.contact}",
                                                      style: tsRequestTitle,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                        width: widthScreen *
                                                            0.55,
                                                        child: Text(
                                                          item.description,
                                                          style:
                                                          tsRequestSubTitle,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          maxLines: 3,
                                                        ))
                                                  ],
                                                ),
                                                request == "Входящий"
                                                    ? Row(
                                                  children: [
                                                    IconButton(
                                                      icon:
                                                      const Icon(
                                                        Icons.check,
                                                      ),
                                                      onPressed:
                                                          () {},
                                                      color:
                                                      cIconColor,
                                                    ),
                                                    IconButton(
                                                      icon:
                                                      const Icon(
                                                        Icons
                                                            .not_interested,
                                                      ),
                                                      onPressed:
                                                          () {},
                                                      color:
                                                      cIconColor,
                                                    ),
                                                  ],
                                                )
                                                    : Text(
                                                  item.status,
                                                  style:
                                                  tsRequestAccepted,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: tDefaultSizeS,
                                      ),
                                    ],
                                  );
                                }) : SpinKitWanderingCubes(
                                    color: Colors.white,
                                    size: 50,
                                  );
                          },
                        );
                      },
                    ),
                  ],
                )
              : SpinKitWanderingCubes(
                  color: Colors.white,
                  size: 50,
                );
        },
      );
    });
  }
}
