import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';

class Requests extends StatelessWidget {
  const Requests({Key? key}) : super(key: key);
  static const List requests = [["Елена" , "Здравствуйте, в последнее время часто чувствую тревожность", "Принят"], ["Елена" , "Здравствуйте, в последнее время часто чувствую тревожность", "Принят"]];

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;

    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final item = requests[index];
            return Column(
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
                          Text(item[2], style: tsRequestAccepted)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: tDefaultSizeS,),
              ],
            );
          }
      ),
    );
  }
}
