import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';

class DoctorRequests extends StatelessWidget {
  const DoctorRequests({super.key, required this.request});
  final String request;
  static const List requests = [["Айша +77477457382" , "Здравствуйте, в последнее время часто чувствую тревожность", "Входящий"], ["Даулет +77477457382" , "Здравствуйте, в последнее время часто чувствую тревожность", "Входящий"], ["Айша2 +77477457382" , "Здравствуйте, в последнее время часто чувствую тревожность", "Принят"], ["Даулет2 +77477457382" , "Здравствуйте, в последнее время часто чувствую тревожность", "Принят"]];

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;

    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final item = requests[index];
            return item[2] == request ?
            Column(
              children: [
                Container(
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(tDefaultSizeS),
                    border: Border.all(
                      color: cIconColor,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item[0], style: tsRequestTitle, ),
                              SizedBox(height: 5,),
                              Container(
                                  width: widthScreen * 0.55,
                                  child: Text(item[1], style: tsRequestSubTitle, overflow: TextOverflow.ellipsis, maxLines: 3,))
                            ],
                          ),
                          request == "Входящий" ?
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check,),
                                onPressed: () {  },
                                color: cIconColor,
                              ),
                              IconButton(
                                icon: const Icon(Icons.not_interested,),
                                onPressed: () {  },
                                color: cIconColor,
                              ),
                            ],
                          ) :
                          Text(item[2], style: tsRequestAccepted,)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: tDefaultSizeS,),
              ],
            ) :
            Container();
          }
      ),
    );
  }
}
